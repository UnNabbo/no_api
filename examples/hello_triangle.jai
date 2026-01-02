#import,file "../module.jai";

#import "Window_Creation";
#import "stb_image";
#import "Input";

#import "Math";

#import "Basic";
#import "File";

Vertex :: struct {
	pos: Vector3 ;
	col: Vector3 ;
	uvs: Vector2 ;
}

main :: (){
	set_working_directory(#filepath);
	window := create_window(1280, 720, "Window Creation");
	quit := false;

	gpu_init(1, {.GENERAL, 1});
	gpu_create_swapchain(window, 1280, 720, .FIFO);
	queue := gpu_create_queue(.GENERAL);
	
	vertex_ir := gpu_generate_shader_ir("res/shader.spv", "v_main");
	fragment_ir := gpu_generate_shader_ir("res/shader.spv", "f_main");
	rasterizer_descriptor: Rasterizer_Descriptor = .{
		color_targets = .[
			.{format = .R8G8B8A8_UNORM}
		]
	};
	
	pipeline := gpu_create_graphic_pipeline(vertex_ir, fragment_ir, rasterizer_descriptor);
	backbuffer := gpu_create_texture({1280, 720, .R8G8B8A8_UNORM, .STORAGE | .COLOR_ATTACHMENT | .TRANSFER_SRC | .TRANSFER_DST });

	vertex := gpu_malloc(3, Vertex);
	vertex[0] = .{{0, -0.5, 0}, {0, 0, 1}, {-1, -1}};
	vertex[1] = .{{0.5, 0.5, 0}, {0, 0, 1},   {1, 1}};
	vertex[2] = .{{-0.5, 0.5, 0}, {0, 0, 1},  {-1, 1}};
	
	indices := gpu_malloc(3, u32);
	indices[0] = 0;
	indices[1] = 1;
	indices[2] = 2;
	
	while !quit {
        update_window_events();
		for get_window_resizes() {
            gpu_resize_swapchain(it.width, it.height);
		}
		
		command_buffer := gpu_start_command_recording(*queue);
		gpu_clear(command_buffer, *backbuffer, {255, 0, 0, 255});
		render_pass: Render_Pass_Descriptor;
		render_pass.color_targets = .[{*backbuffer, .LOAD, .STORE, 0}];
		gpu_begin_render_pass(command_buffer, render_pass);
		gpu_bind_pipeline(*command_buffer, *pipeline);

		gpu_draw_indexed(command_buffer, gpu_host_to_device_address(vertex), null, indices, 3);
		gpu_end_render_pass(command_buffer);
	
		if gpu_present(command_buffer, *queue, *backbuffer) then break;
		gpu_end_command_recording(command_buffer);
		
		gpu_submit(*queue, command_buffer);
    }
}
