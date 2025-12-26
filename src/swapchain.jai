// Nabbo - 2025 / 11 / 22 - 08:04:09



Swap_Chain_Present_Mode :: enum u32{
	IMMEDIATE				  :: 0;
	MAILBOX					  :: 1;
	FIFO					  :: 2;
	FIFO_RELAXED			  :: 3;
	SHARED_DEMAND_REFRESH	  :: 1000111000;
	SHARED_CONTINUOUS_REFRESH :: 1000111001;
}

#scope_module

Swapchain :: struct{
	#as handle: VkSwapchainKHR;
	images: [] Texture;
	extent: VkExtent2D;
	surface_format: VkSurfaceFormatKHR;
	present_mode: Swap_Chain_Present_Mode;
	current_image: u32;

	current_sync: u32;
	semaphores: [] Semaphore;
}

create_swapchain :: (surface: Surface, width:s32, height: s32, present_mode: Swap_Chain_Present_Mode, old_handle: VkSwapchainKHR = VK_NULL_HANDLE) -> Swapchain {
	swapchain: Swapchain;


	swapchain.surface_format = .{.R8G8B8A8_UNORM, .COLOR_SPACE_SRGB_NONLINEAR_KHR};
	swapchain.present_mode = xx present_mode;
	swapchain.extent = .{xx width, xx height};

	image_count := ifx (!surface.capabilities.maxImageCount) then surface.capabilities.minImageCount + 1 else clamp_hi(surface.capabilities.minImageCount + 1, surface.capabilities.maxImageCount);
	
	swapchain_create_info: VkSwapchainCreateInfoKHR;
	swapchain_create_info.surface = surface.handle;
	swapchain_create_info.minImageCount = image_count;
	swapchain_create_info.imageFormat = swapchain.surface_format.format;
	swapchain_create_info.imageColorSpace = swapchain.surface_format.colorSpace;
	swapchain_create_info.imageExtent = swapchain.extent;
	swapchain_create_info.imageArrayLayers = 1;
	swapchain_create_info.imageUsage = .COLOR_ATTACHMENT_BIT | .TRANSFER_DST_BIT;

	swapchain_create_info.imageSharingMode = .EXCLUSIVE;
	swapchain_create_info.queueFamilyIndexCount = 0;
	swapchain_create_info.pQueueFamilyIndices = null;
	swapchain_create_info.preTransform = surface.capabilities.currentTransform;
	swapchain_create_info.compositeAlpha = .OPAQUE_BIT_KHR;
	swapchain_create_info.presentMode = xx present_mode; 
	swapchain_create_info.clipped = VK_TRUE;
	swapchain_create_info.oldSwapchain = old_handle;

	// // MIN_BIT_EXT            :: 0x1;
    // // MAX_BIT_EXT            :: 0x2;
    // // CENTERED_BIT_EXT       :: 0x4;
	//     ONE_TO_ONE_BIT_EXT           :: 0x1;
    // ASPECT_RATIO_STRETCH_BIT_EXT :: 0x2;
    // STRETCH_BIT_EXT              :: 0x4;
    // FLAG_BITS_MAX_ENUM_EXT       :: 0x7fffffff;

#if false{
	scaling :VkSwapchainPresentScalingCreateInfoEXT;
	scaling.scalingBehavior = .STRETCH_BIT_EXT;
	scaling.presentGravityX = .MIN_BIT_EXT;
	scaling.presentGravityY = .MIN_BIT_EXT;
	swapchain_create_info.pNext = *scaling;
	
}
	vk_assert(vkCreateSwapchainKHR(device.handle, *swapchain_create_info, null, *swapchain.handle));
	
	swapchain.images = array_new(image_count, Texture);
	swapchain.semaphores = array_new(image_count, Semaphore);
	raw_images := array_new(image_count, VkImage,, temp);
	vkGetSwapchainImagesKHR(device.handle, swapchain.handle, *image_count, raw_images.data);

	for * swapchain.semaphores{
		it.* = gpu_create_binary_semaphore();
	}
	
	for raw_images{
		swapchain.images[it_index].handle = it;
		swapchain.images[it_index].layout = .UNDEFINED;
		swapchain.images[it_index].format = .R8G8B8A8_UNORM;
		swapchain.images[it_index].extent = .{xx width, xx height, 1};
	}
	return swapchain;
}

destroy_swapchain :: (swapchain: *Swapchain){
	vkDeviceWaitIdle(device);
	vkDestroySwapchainKHR(device, swapchain, null);
	array_free(swapchain.images);
}

Surface :: struct {
	#as handle: VkSurfaceKHR;
	capabilities: VkSurfaceCapabilitiesKHR ;
	formats: [..] VkSurfaceFormatKHR;
	present_modes: [..] VkPresentModeKHR;
	window_handle: *void;
}

create_surface :: (window_handle: * void) -> Surface { 
	#import "Windows";
	surface: Surface;
	surface.window_handle = window_handle;
	
	surface_info: VkWin32SurfaceCreateInfoKHR;
	surface_info.hwnd = cast(HWND, window_handle);
	surface_info.hinstance = GetModuleHandleA(null);
	
	vk_assert(vkCreateWin32SurfaceKHR(instance.handle, *surface_info, null, *surface.handle));
	
	vkGetPhysicalDeviceSurfaceCapabilitiesKHR(physical_device.handle, surface.handle, *surface.capabilities);

	format_count: u32;
	vkGetPhysicalDeviceSurfaceFormatsKHR(physical_device.handle, surface.handle, *format_count, null);
	array_resize(*surface.formats, format_count);
	vkGetPhysicalDeviceSurfaceFormatsKHR(physical_device.handle, surface.handle, *format_count, surface.formats.data);
	
	present_mode_count: u32;
	vkGetPhysicalDeviceSurfacePresentModesKHR(physical_device.handle, surface.handle, *present_mode_count, null);
	array_resize(*surface.present_modes, present_mode_count);
	vkGetPhysicalDeviceSurfacePresentModesKHR(physical_device.handle, surface.handle, *present_mode_count, surface.present_modes.data);
	
	return surface;
}
