#import "no_api" ;

#import "Window_Creation";
#import "Input";

#import "Math";

#import "Basic";
#import "File";

Data :: struct {
	color: Vector4;
	_: void #align 16;
}

main :: (){
	set_working_directory(#filepath);
	
	window := create_window(1280, 720, "Window Creation");
	quit := false;

	gpu_init({.COMPUTE, 1});
	gpu_create_swapchain(window, 1280, 720, .MAILBOX);
	
	compute_queue := gpu_create_queue(.COMPUTE);
	
	shader_ir := gpu_generate_shader_ir("shader.spv");
	pipeline := gpu_create_compute_pipeline(shader_ir);

	cpu := gpu_malloc(1, u32);
	cpu.* = 69;
	gpu := gpu_host_to_device_address(cpu);
	
    while !quit {
        update_window_events();
		for get_window_resizes() {
			log("%", it);
		}
		
		command_buffer := gpu_start_command_recording(*compute_queue);
		gpu_clear(command_buffer, swapchain.images[swapchain.current_image], {255, 0, 0, 255});
		
		gpu_bind_pipeline(*command_buffer, pipeline);
		gpu_dispatch(command_buffer, gpu, 1, 1, 1);
		
		gpu_present(command_buffer, *compute_queue);
		gpu_end_command_recording(command_buffer);
		
		gpu_submit(*compute_queue, command_buffer);
		
		for events_this_frame {
            if it.type == .QUIT then quit = true;
            if it.type == .KEYBOARD {
                if it.key_pressed == 0 continue;

                if it.key_code == .ESCAPE {
                    quit = true;
                }
            }
        }
    }
	
}
