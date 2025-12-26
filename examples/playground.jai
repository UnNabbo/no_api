#import "no_api"() ;

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

Vertex :: struct {
	pos: Vector3 ;
	col: Vector3 ;
	uvs: Vector2 ;
}

main :: (){
	set_working_directory(#filepath);
	
	window := create_window(1280, 720, "Window Creation");
	quit := false;

    image_width, image_height, channels: s32;
    //stbi_set_flip_vertically_on_load(1);
    image_data := stbi_load("res/image.png", *image_width, *image_height, *channels, 0);
    image_size := image_width * image_height * channels;
    defer stbi_image_free(image_data);
	log("Loaded image of size: %, %", image_size, channels);
	//GPU API INITIALIZATION
	
	gpu_init(32, {.GENERAL, 1});
	//gpu_create_swapchain(window, 1280, 720, .MAILBOX);
	gpu_create_swapchain(window, 1280, 720, .FIFO);
	compute_queue := gpu_create_queue(.GENERAL);

	compute_ir := gpu_generate_shader_ir("res/compute.spv");
	pipeline := gpu_create_compute_pipeline(compute_ir);

	vertex_ir := gpu_generate_shader_ir("res/shader.spv", "v_main");
	fragment_ir := gpu_generate_shader_ir("res/shader.spv", "f_main");
	rasterizer_descriptor: Rasterizer_Descriptor = .{
		color_targets = .[
			.{format = .R8G8B8A8_UNORM}
		]
	};
	gpipeline := gpu_create_graphic_pipeline(vertex_ir, fragment_ir, rasterizer_descriptor);
	
	upload_memory := gpu_malloc(image_size);
    memcpy(upload_memory, image_data, image_size);

	info: Texture_Info;
	info.width = xx image_width;
	info.height = xx image_height;
	info.format = .R8G8B8A8_UNORM;
	texture := gpu_create_texture(info);

	compute := gpu_create_texture({1280, 720, .R8G8B8A8_UNORM, .STORAGE | .TRANSFER_SRC | .TRANSFER_DST });
	backbuffer := gpu_create_texture({1280, 720, .R8G8B8A8_UNORM, .STORAGE | .COLOR_ATTACHMENT | .TRANSFER_SRC | .TRANSFER_DST });
	
	texture_heap := gpu_create_texture_heap();
	rw_texture_heap :=  gpu_create_rw_texture_heap();
	
	gpu_create_rw_texture_view_descriptor(backbuffer, rw_texture_heap, 0);
	gpu_create_texture_view_descriptor(texture, texture_heap, 0);
	
	upload_buffer := gpu_start_command_recording(*compute_queue);

	gpu_copy_to_texture(upload_buffer, *texture, upload_memory);
	//other copies...
	
	gpu_barrier(upload_buffer, .TRANSFER, .ALL, .DESCRIPTORS);
	gpu_end_command_recording(upload_buffer);
	gpu_submit(*compute_queue, upload_buffer);


	//RENDERING LOOP
	
	FRAMES_IN_FLIGHT :: 1;
	frame_semaphore := gpu_create_semaphore();
	frame: u64 = 1;
	
	vertex := alloc_and_map(3, Vertex);
	vertex.cpu[0] = .{{-0.5, -0.5, 0}, {1, 1, 0}, {-1, -1}};
	vertex.cpu[1] = .{{0.5, 0.5, 0}, {1, 0, 0},   {1, 1}};
	vertex.cpu[2] = .{{-0.5, 0.5, 0}, {1, 0, 1},  {-1, 1}};
	indices := alloc_and_map(3, u32);
	indices.cpu[0] = 0;
	indices.cpu[1] = 1;
	indices.cpu[2] = 2;


	//delete(*tree, 10, 15);
	
    while !quit {
        update_window_events();
		for get_window_resizes() {
            gpu_resize_swapchain(it.width, it.height);
		}


		if frame > FRAMES_IN_FLIGHT then gpu_wait_semaphore(frame_semaphore, frame );
		
		command_buffer := gpu_start_command_recording(*compute_queue);
		
		//gpu_clear(command_buffer, *dst_texture, {255, 0, 0, 255});
		
		gpu_bind_pipeline(*command_buffer, *pipeline);
		gpu_bind_texture_heap(command_buffer, texture_heap, rw_texture_heap);
		gpu_dispatch(command_buffer, null, 1280 / 16, 720 / 16, 1);

		gpu_barrier(command_buffer, .COMPUTE_SHADER, .ALL_GRAPHICS, .DESCRIPTORS);
 
		render_pass: Render_Pass_Descriptor;
		render_pass.color_targets = .[{*backbuffer, .LOAD, .STORE, 0}];
		gpu_begin_render_pass(command_buffer, render_pass);
		gpu_bind_pipeline(*command_buffer, *gpipeline);
		gpu_bind_texture_heap(command_buffer, texture_heap, rw_texture_heap);

		gpu_draw_indexed(command_buffer, vertex.gpu, null, indices.cpu, 3);
		gpu_end_render_pass(command_buffer);

#if false{
		barrier := gpu_create_barrier();
		defer gpu_destroy_barrier(barrier);
		gpu_signal_after(command_buffer, .ALL, *barrier);
		gpu_wait_before(command_buffer, .HOST, *barrier);
}
		
	
		gpu_present(command_buffer, *compute_queue, *backbuffer);
		gpu_end_command_recording(command_buffer);
		
		gpu_submit(*compute_queue, frame_semaphore, frame + 1, command_buffer);
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

Allocation :: struct($type: Type) {
	#as cpu: *type;
	gpu: *type;
}
alloc_and_map :: (size: s64) -> Allocation(void) {
	al: Allocation(void);
	al.cpu = gpu_malloc(size);
	al.gpu = gpu_host_to_device_address(al.cpu);
	return al;
}

alloc_and_map :: (count: s64, $type: Type) -> Allocation(type) {
	al: Allocation(type);
	al.cpu = gpu_malloc(count, type);
	al.gpu = gpu_host_to_device_address(al.cpu);
	return al;
}
