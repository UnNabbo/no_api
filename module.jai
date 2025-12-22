#module_parameters(RENDERING_DEBUG := true);

#load "src/utils.jai";

#load "src/init.jai";
#load "src/sync.jai";
#load "src/memory.jai";
#load "src/commands.jai";
#load "src/swapchain.jai";
#load "src/pipeline.jai";

Handle :: struct($kind: Type) {
	
}

gpu_init :: (queues: ..Queue_Request_Entry) {
	instance = create_instance();
	physical_device = create_physical_device(*instance);
	device = create_device(*physical_device, ..queues);
	device.allocator = create_gpu_allocator();
}

gpu_create_swapchain :: (window: *void, width:s32, height: s32, present_mode: Swap_Chain_Present_Mode) {
	swapchain = create_swapchain(window, width, height, present_mode);
}

using ctx: Rendering_Context;
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
}

