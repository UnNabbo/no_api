#module_parameters(RENDERING_DEBUG := true);

#load "src/utils.jai";
#load "src/init.jai";
#load "src/sync.jai";
#load "src/memory.jai";
#load "src/commands.jai";
#load "src/swapchain.jai";
#load "src/pipeline.jai";

gpu_init :: (texture_heap_size: s64, queues: ..Queue_Request_Entry) {
	gpu_init(texture_heap_size, texture_heap_size, ..queues);
}

gpu_init :: (texture_heap_size: s64, rwtexture_heap_size: s64, queues: ..Queue_Request_Entry) {
	instance = create_instance();
	physical_device = create_physical_device(*instance);
	device = create_device(*physical_device, ..queues);
	device.allocator = create_gpu_allocator();

	ctx.texture_heap_size = texture_heap_size;
	ctx.rwtexture_heap_size = rwtexture_heap_size;
}

gpu_create_swapchain :: (window: *void, width:s32, height: s32, present_mode: Swap_Chain_Present_Mode) {
	window_ptr = window;
	surface := create_surface(window_ptr);
	swapchain = create_swapchain(surface, width, height, present_mode);
}

gpu_resize_swapchain :: (width:s32, height: s32) {
	surface := create_surface(window_ptr);
	swapchain = create_swapchain(surface, width, height, swapchain.present_mode, swapchain);
}

#scope_module;

#import "Basic";
#import "Flat_Pool";
#import "Hash_Table";
#import "Math";
#import "File";
#import "Thread";
#import "System";

#import "vulkan";
#import "vulkan_memory_allocator";

Rendering_Context :: struct{
	instance: Instance;
	physical_device: Physical_Device;
	device: Device;
	swapchain: Swapchain;
	
	texture_heap_size, rwtexture_heap_size: s64;

	window_ptr: *void;
}

using ctx: Rendering_Context;
