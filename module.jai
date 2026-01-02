#module_parameters(IMPORT_SLANG_COMPILER := true, RENDERING_DEBUG := true);

#load "src/utils.jai";
#load "src/init.jai";
#load "src/sync.jai";
#load "src/memory.jai";
#load "src/commands.jai";
#load "src/swapchain.jai";
#load "src/pipeline.jai";
#if IMPORT_SLANG_COMPILER then #load "src/shader_compiler.jai";

gpu_init :: (texture_heap_size: s64, queues: ..Queue_Request_Entry) {
	gpu_init(texture_heap_size, texture_heap_size, ..queues);
}

gpu_init :: (texture_heap_size: s64, rwtexture_heap_size: s64, queues: ..Queue_Request_Entry) {
	gpu_context = new(Rendering_Context);
	
	instance = create_instance();
	physical_device = create_physical_device(*instance);
	device = create_device(*physical_device, ..queues);
	device.allocator = create_gpu_allocator();

	gpu_context.texture_heap_size = texture_heap_size;
	gpu_context.rwtexture_heap_size = rwtexture_heap_size;

    #if IMPORT_SLANG_COMPILER then Slang.slang_createGlobalSession(Slang.SLANG_API_VERSION, *slang_global_session);
}

gpu_create_swapchain :: (window: Window_Type, width:s32, height: s32, present_mode: Swap_Chain_Present_Mode) {
	window_handle = window;
	surface = create_surface(window_handle);
	swapchain = create_swapchain(surface, width, height, present_mode);
}

gpu_resize_swapchain :: (width: s32, height: s32) {
	vkDeviceWaitIdle(device);
	destroy_swapchain(*swapchain);
	destroy_surface(*surface);
	surface = create_surface(window_handle);
	swapchain = create_swapchain(surface, width, height, swapchain.present_mode);
}

gpu_context: *Rendering_Context;

#scope_module;

#import "Basic";
#import "Flat_Pool";
#import "Hash_Table";
#import "Math";
#import "File";
#import "Thread";
#import "String";
#import "System";

Slang :: #import,dir "modules/slang";
#import,dir "modules/vulkan";
#import,dir "modules/vulkan_memory_allocator";

WT :: #import "Window_Type";  // Define this for the people.
Window_Type :: WT.Window_Type;

Rendering_Context :: struct{
	instance: Instance;
	physical_device: Physical_Device;
	device: Device;
	swapchain: Swapchain;
	surface: Surface;
	
	window_handle: Window_Type;
	texture_heap_size, rwtexture_heap_size: s64;
	
	#if IMPORT_SLANG_COMPILER then slang_global_session: *Slang.IGlobalSession;
}


using gpu_context;
