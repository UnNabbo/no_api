#import "no_api" ;

#import "Window_Creation";
#import "stb_image";
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

    image_width, image_height, channels: s32;
    //stbi_set_flip_vertically_on_load(1);
    image_data := stbi_load("image.png", *image_width, *image_height, *channels, 0);
    image_size := image_width * image_height * channels;
    defer stbi_image_free(image_data);

	//GPU API INITIALIZATION
	
	gpu_init({.GENERAL, 1});
	//gpu_create_swapchain(window, 1280, 720, .MAILBOX);
	gpu_create_swapchain(window, 1280, 720, .FIFO);
	compute_queue := gpu_create_queue(.GENERAL);

	shader_ir := gpu_generate_shader_ir("shader.spv");
	pipeline := gpu_create_compute_pipeline(shader_ir);

	texture_heap := gpu_malloc(65565, Texture_Descriptor);

	upload_memory := gpu_malloc(image_size);
    memcpy(upload_memory, image_data, image_size);

	info: Texture_Info;
	info.width = xx image_width;
	info.height = xx image_height;
	texture := gpu_create_texture(info);
	
	dst_texture := gpu_create_texture({1280, 720, .R8G8B8A8_UNORM, .STORAGE | .TRANSFER_SRC | .TRANSFER_DST});

	gpu_create_texture_view_descriptor(texture, *texture_heap[0]);
	gpu_create_texture_view_descriptor(dst_texture, *texture_heap[1]);
	
	upload_buffer := gpu_start_command_recording(*compute_queue);

	gpu_copy_to_texture(upload_buffer, *texture, upload_memory);
	//other copies...
	
	gpu_barrier(upload_buffer, .TRANSFER, .ALL, .DESCRIPTORS);
	gpu_end_command_recording(upload_buffer);
	gpu_submit(*compute_queue, upload_buffer);
	//RENDERING LOOP
	
	FRAMES_IN_FLIGHT :: 2;
	frame_semaphore := gpu_create_semaphore();
	frame: u64 = 1;
	
	data := alloc_and_map(size_of(u32));
    while !quit {
        update_window_events();
		for get_window_resizes() {
			log("%", it);
		}

		if frame > FRAMES_IN_FLIGHT then gpu_wait_semaphore(frame_semaphore, frame - FRAMES_IN_FLIGHT);
		
		command_buffer := gpu_start_command_recording(*compute_queue);
		
		gpu_clear(command_buffer, *dst_texture, {255, 0, 0, 255});
		
		gpu_bind_pipeline(*command_buffer, pipeline);
		gpu_bind_texture_heap(command_buffer, gpu_host_to_device_address(texture_heap));
		gpu_dispatch(command_buffer, data.gpu, 1, 1, 1);
		gpu_blit_textures(command_buffer, *dst_texture, *swapchain.images[swapchain.current_image]);
		gpu_present(command_buffer, *compute_queue);
		gpu_end_command_recording(command_buffer);
		
		gpu_submit(*compute_queue, frame_semaphore, frame, command_buffer);
		frame += 1;
		
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

Allocation :: struct {
	#as cpu: *void;
	gpu: *void;
}
alloc_and_map :: (size: s64) -> Allocation {
	al: Allocation;
	al.cpu = gpu_malloc(size);
	al.gpu = gpu_host_to_device_address(al.cpu);
	return al;
}
