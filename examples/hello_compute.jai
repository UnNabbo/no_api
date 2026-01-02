#import,file "../module.jai";

#import "Window_Creation";
#import "stb_image";
#import "Input";

#import "Math";

#import "Basic";
#import "File";

main :: (){
	set_working_directory(#filepath);
	window := create_window(1280, 720, "Window Creation");
	quit := false;

	gpu_init(1, {.GENERAL, 1});
	gpu_create_swapchain(window, 1280, 720, .FIFO);
	queue := gpu_create_queue(.GENERAL);
	
	compute_ir := gpu_generate_shader_ir("res/compute.spv");
	pipeline := gpu_create_compute_pipeline(compute_ir);
	backbuffer := gpu_create_texture({1280, 720, .R8G8B8A8_UNORM, .STORAGE | .COLOR_ATTACHMENT | .TRANSFER_SRC | .TRANSFER_DST });

	rw_texture_heap := gpu_create_rw_texture_heap();
	gpu_create_rw_texture_view_descriptor(backbuffer, rw_texture_heap, 0);

	while !quit {
        update_window_events();
		for get_window_resizes() {
            gpu_resize_swapchain(it.width, it.height);
		}
		
		command_buffer := gpu_start_command_recording(*queue);
		
		gpu_bind_pipeline(*command_buffer, *pipeline);
		gpu_bind_texture_heap(command_buffer, null, rw_texture_heap);
		gpu_dispatch(command_buffer, null, 1280 / 16, 720 / 16, 1);
	
		if gpu_present(command_buffer, *queue, *backbuffer) then break;
		gpu_end_command_recording(command_buffer);
		
		gpu_submit(*queue, command_buffer);
    }
}
