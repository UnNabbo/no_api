#scope_module;

Device :: struct { 
	#as handle: VkDevice;
	physical_device: *Physical_Device;
	created_queues: [..] Queue_Family;
	allocator: GPU_Allocator;
}

Queue_Family :: struct {
	Kind :: enum {
		INVALID :: -1;
		
		GENERAL :: 0;
		GRAPHIC :: GENERAL;
		COMPUTE;
		TRANSFER;
	}

	kind: Kind =  .INVALID;
	index: u32 = cast,no_check(u32, -1);
	count: u32 =  0;
	used:  u32 =  0;
}

Physical_Device :: struct {
	#as handle : VkPhysicalDevice;
	instance: *Instance;
	available_queues: [] Queue_Family;
}

Instance :: struct{
	#as handle: VkInstance;
	#if RENDERING_DEBUG{
		debug_messenger: VkDebugUtilsMessengerEXT ;
	}
}

create_instance :: () -> Instance	 {
	instance: Instance;
	
	app_info: VkApplicationInfo;
	app_info.pApplicationName = "Editor";
	app_info.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
	app_info.pEngineName = "No Engine";
	app_info.engineVersion = VK_MAKE_VERSION(1, 0, 0);
	app_info.apiVersion = VK_API_VERSION_1_3;

	instance_info: VkInstanceCreateInfo;
	instance_info.pApplicationInfo = *app_info;

	//TODO MAYBE CHECK FOR SUPPORT
	#if RENDERING_DEBUG{
		extensions: []* u8 = .[
		VK_KHR_SURFACE_EXTENSION_NAME, VK_KHR_WIN32_SURFACE_EXTENSION_NAME, VK_EXT_SURFACE_MAINTENANCE_1_EXTENSION_NAME, VK_KHR_GET_SURFACE_CAPABILITIES_2_EXTENSION_NAME, "VK_EXT_debug_utils"];
	}else{
		extensions: []* u8 = .[
		VK_KHR_SURFACE_EXTENSION_NAME, VK_EXT_SURFACE_MAINTENANCE_1_EXTENSION_NAME, VK_KHR_GET_SURFACE_CAPABILITIES_2_EXTENSION_NAME, VK_KHR_WIN32_SURFACE_EXTENSION_NAME];
	}
	
	instance_info.enabledExtensionCount = xx extensions.count;
	instance_info.ppEnabledExtensionNames = extensions.data;
	
	#if RENDERING_DEBUG{
		//TODO MAYBE CHECK FOR SUPPORT
		validation_layers: [] *u8 = .[
		"VK_LAYER_LUNARG_monitor", "VK_LAYER_KHRONOS_validation"
		]; 

		instance_info.enabledLayerCount = xx validation_layers.count;
		instance_info.ppEnabledLayerNames = validation_layers.data;

		messenger_info: VkDebugUtilsMessengerCreateInfoEXT;
		messenger_info.messageSeverity = .VERBOSE_BIT_EXT | .WARNING_BIT_EXT | .ERROR_BIT_EXT;
		messenger_info.messageType = .GENERAL_BIT_EXT | .VALIDATION_BIT_EXT | .PERFORMANCE_BIT_EXT;
	
		debug_callback :: (message_severity: VkDebugUtilsMessageSeverityFlagBitsEXT,
			message_type: VkDebugUtilsMessageTypeFlagsEXT,
			callback_data: *VkDebugUtilsMessengerCallbackDataEXT,
			user_data: *void
		) -> VkBool32 #c_call{
			push_context,defer_pop cast(*#Context, user_data).*;

			if message_severity == .ERROR_BIT_EXT {
				log_error("[Vulkan][Error]: %", to_string(callback_data.pMessage));
				//assert(false, "Read error message above");
			}else{
				log("[Vulkan][Info]: %", to_string(callback_data.pMessage));
			}
			print("\n");
			return VK_FALSE;
			
		}
		

	
		messenger_info.pfnUserCallback = debug_callback;
		messenger_info.pUserData = *context;

		instance_info.pNext = *messenger_info;
	}

	vk_assert(vkCreateInstance(*instance_info, null, *instance.handle));

	#if RENDERING_DEBUG{
		get_instance_proc_add(instance.handle, "vkCreateDebugUtilsMessengerEXT");
		vk_assert(vkCreateDebugUtilsMessengerEXT(instance.handle, *messenger_info, null, *instance.debug_messenger));
	}
	


	return instance; 
}

create_physical_device :: (instance: *Instance) -> Physical_Device{
	device: Physical_Device;
	device.instance = instance;
	device_extensions: []*u8 = .[
		VK_KHR_SWAPCHAIN_EXTENSION_NAME, VK_KHR_VARIABLE_POINTERS_EXTENSION_NAME
	];

	device_count: u32;
	vkEnumeratePhysicalDevices(instance.handle, *device_count, null);

	
	devices: [..] VkPhysicalDevice;
	defer array_free(devices);
	array_resize(*devices, device_count);
	
	vkEnumeratePhysicalDevices(instance.handle, *device_count, devices.data);
	for physical_device : devices{
		device_properties: VkPhysicalDeviceProperties;
		vkGetPhysicalDeviceProperties(physical_device, *device_properties);
		if device_properties.apiVersion < VK_API_VERSION_1_3 then continue;
		
		device_features: VkPhysicalDeviceFeatures;
		vkGetPhysicalDeviceFeatures(physical_device, *device_features);
		
		extension_count: u32;
		vkEnumerateDeviceExtensionProperties(physical_device, null, *extension_count, null);
		available_extensions := array_new(extension_count, VkExtensionProperties);
		defer array_free(available_extensions);
		vkEnumerateDeviceExtensionProperties(physical_device, null, *extension_count, available_extensions.data);
		
		req_ext := device_extensions.count;
		for extension : available_extensions {
			for j : 0..device_extensions.count - 1 {
				if to_string(*extension.extensionName[0]) == to_string(device_extensions[j]) {
					req_ext -= 1;
				}
			}
		
			if !req_ext then break;
		}
		
		assert(!req_ext, "Not all required extensions are supported");
		
		
		
		queue_family_count: u32;
		vkGetPhysicalDeviceQueueFamilyProperties(physical_device, *queue_family_count, null);
		queue_families := array_new(queue_family_count, VkQueueFamilyProperties);
		defer array_free(queue_families);
		vkGetPhysicalDeviceQueueFamilyProperties(physical_device, *queue_family_count, queue_families.data);
		// GRAPHICS_BIT         :: 0x1;
		// COMPUTE_BIT          :: 0x2;
		// TRANSFER_BIT         :: 0x4;
		// SPARSE_BINDING_BIT   :: 0x8;
		// PROTECTED_BIT        :: 0x10;
		// VIDEO_DECODE_BIT_KHR :: 0x20;
		// VIDEO_ENCODE_BIT_KHR :: 0x40;
		// OPTICAL_FLOW_BIT_NV  :: 0x100;
		// FLAG_BITS_MAX_ENUM   :: 0x7fffffff;
		families: [..] Queue_Family;
		for queue_families{
			if it.queueFlags & (.VIDEO_DECODE_BIT_KHR | .VIDEO_ENCODE_BIT_KHR | .OPTICAL_FLOW_BIT_NV) then continue;
			if (it.queueFlags & .GRAPHICS_BIT) &&  (it.queueFlags & .COMPUTE_BIT) && (it.queueFlags & .TRANSFER_BIT)  {
				array_add(*families, .{.GENERAL, xx it_index, it.queueCount, 0});
			}else{
				if !(it.queueFlags & .GRAPHICS_BIT)  {
					if it.queueFlags &  .TRANSFER_BIT{
						if it.queueFlags & .COMPUTE_BIT{
							array_add(*families, .{.COMPUTE, xx it_index, it.queueCount, 0});
						}else{
							array_add(*families, .{.TRANSFER, xx it_index, it.queueCount, 0});
						}
					}
				}
			}
		}

		if (device_properties.deviceType == .DISCRETE_GPU) {
			device.available_queues = families;
			device.handle = physical_device;
			log("%", families);
			break;
		}else{
			array_free(families);
		}
	}
	return device;
}

Queue_Request_Entry :: struct{
	kind: Queue_Family.Kind;
	count: u32;
}

create_device :: (physical_device: *Physical_Device, queues: ..Queue_Request_Entry) -> Device{
	device : Device;
	device.physical_device = physical_device;
	queue_priority := 1.0;


	queue_create_infos: [..] VkDeviceQueueCreateInfo;
	defer array_free(queue_create_infos);
	for entry: queues {
		for * physical_device.available_queues {
			if it.kind == entry.kind && it.used + 1 < it.count {
				it.used += 1;
				array_add(*device.created_queues, .{it.kind, it.index, entry.count, 0});
				
				queue_create_info: VkDeviceQueueCreateInfo;
				queue_create_info.queueFamilyIndex = xx it.index;
				queue_create_info.queueCount = xx entry.count;
				queue_create_info.pQueuePriorities = *queue_priority;
				array_add(*queue_create_infos, queue_create_info);
				
				break;
			}
		}
	}

	device_create_info: VkDeviceCreateInfo;
	device_create_info.pQueueCreateInfos = queue_create_infos.data;
	device_create_info.queueCreateInfoCount = xx queue_create_infos.count;

	device_features: VkPhysicalDeviceFeatures2;


	features13: VkPhysicalDeviceVulkan13Features;
	features13.dynamicRendering = 1;
	features13.synchronization2 = 1;

	features12: VkPhysicalDeviceVulkan12Features;
	features12.pNext = *features13;
	features12.bufferDeviceAddress = 1;
	features12.descriptorIndexing = 1;

	features11: VkPhysicalDeviceVulkan11Features;
	features11.pNext = *features12;
	features11.variablePointers  = 1;
	features11.variablePointersStorageBuffer = 1;
	
	device_features.pNext = *features11;
	
	vkGetPhysicalDeviceFeatures2(physical_device, *device_features);
	
	device_create_info.pNext = *device_features;

	device_extensions: [] *u8 = .[
		VK_KHR_SWAPCHAIN_EXTENSION_NAME, VK_KHR_VARIABLE_POINTERS_EXTENSION_NAME, VK_KHR_DYNAMIC_RENDERING_EXTENSION_NAME, VK_KHR_SYNCHRONIZATION_2_EXTENSION_NAME, VK_KHR_BUFFER_DEVICE_ADDRESS_EXTENSION_NAME, "VK_KHR_unified_image_layouts", VK_EXT_DESCRIPTOR_INDEXING_EXTENSION_NAME, VK_EXT_SWAPCHAIN_MAINTENANCE_1_EXTENSION_NAME
	];
	
	device_create_info.ppEnabledExtensionNames = device_extensions.data;
	device_create_info.enabledExtensionCount = xx device_extensions.count;
	
	vk_assert(vkCreateDevice(physical_device.handle, *device_create_info, null, *device.handle));
	return device;
}

destroy_instance :: (instance: *Instance){
	assert(xx *instance.handle, "Istance is 0x00");
	#if RENDERING_DEBUG{
		vkDestroyDebugUtilsMessengerEXT: PFN_vkDestroyDebugUtilsMessengerEXT = xx vkGetInstanceProcAddr(instance.handle, "vkDestroyDebugUtilsMessengerEXT");
		vkDestroyDebugUtilsMessengerEXT(instance.handle, instance.debug_messenger, null);
	}
	vkDestroyInstance(instance.handle, null);
}

destroy_device :: (device: *Device){
	vkDeviceWaitIdle(device);
	vkDestroyDevice(device, null);
}
