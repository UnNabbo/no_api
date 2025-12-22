Pipeline :: struct{
	Kind :: enum {
		GRAPHIC                :: 0;
		COMPUTE                :: 1;
		RAY_TRACING            :: 1000165000; 
	}
	
	#as handle: VkPipeline;
	layout: VkPipelineLayout;
	
	usage: Kind;
}

Blending:: struct {
	Op :: enum {
		ADD;
		SUBTRACT;
		REV_SUBTRACT;
		MIN;
		MAX;
	}
	
	Factor :: enum  {
		ZERO;
		ONE;
		SRC_COLOR;
		DST_COLOR;
		SRC_ALPHA;
	}

    color_op: Op = .ADD;
    srcColorFactor: Factor = .ONE;
    dstColorFactor: Factor = .ZERO;
    alpha_op: Op = .ADD;
    src_alpha_factor: Factor = .ONE;
    dst_alpha_factor: Factor = .ZERO;
    color_write_mask: u8 = 0xf;
};

Color_Target :: struct {
    format: Texture.Format = .NONE;
    write_mask: u8 = 0xf;
};

Rasterizer :: struct
{
	Topology :: enum{
		NONE                          :: -1;
		POINT_LIST                    ::  0;
		LINE_LIST                     ::  1;
		LINE_STRIP                    ::  2;
		TRIANGLE_LIST                 ::  3;
		TRIANGLE_STRIP                ::  4;
		TRIANGLE_FAN                  ::  5;
		LINE_LIST_WITH_ADJACENCY      ::  6;
		LINE_STRIP_WITH_ADJACENCY     ::  7;
		TRIANGLE_LIST_WITH_ADJACENCY  ::  8;
		TRIANGLE_STRIP_WITH_ADJACENCY ::  9;
		PATCH_LIST                    :: 10;
	}

	Cull :: enum{
		NONE              :: -1;
		COUNTER_CLOCKWISE ::  0;
		CLOCKWISE         ::  1;
	} 
	
    topology: Topology = .TRIANGLE_LIST;
    cull: Cull = .NONE;
    alpha_to_coverage: bool = false;
    dual_source_blending: = false;
    sample_count: u8 = 1;
    depth_format: Texture.Format = .NONE;
    stencil_format: Texture.Format = .NONE;
    blend_state: *Blending = null; // optional embedded blend state
    color_targets: [] Color_Target;
};

//VkDeviceAddress 

gpu_create_graphic_pipeline :: (vertex: Shader_IR, fragment: Shader_IR, rasterizer: Rasterizer = .{}) -> Pipeline{
	pipeline: Pipeline;
	pipeline.usage = .GRAPHIC;
	return pipeline;
}
gpu_create_compute_pipeline :: (ir: Shader_IR) -> Pipeline{
	pipeline: Pipeline;
	pipeline.usage = .COMPUTE;

	push_constant_info: VkPushConstantRange;
	push_constant_info.offset = 0;
	push_constant_info.size = xx size_of(VkDeviceAddress);
	push_constant_info.stageFlags = .COMPUTE_BIT;
	
	compute_layout: VkPipelineLayoutCreateInfo;
	compute_layout.pPushConstantRanges = *push_constant_info;
	compute_layout.pushConstantRangeCount = 1;
	
	texture_layout := create_texture_heap_descriptor_set_layout();
	compute_layout.pSetLayouts = *texture_layout;
	compute_layout.setLayoutCount = 1;
	
	vk_assert(vkCreatePipelineLayout(device, *compute_layout, null, *pipeline.layout));

	compute_pipeline_create_info: VkComputePipelineCreateInfo;
	compute_pipeline_create_info.layout = pipeline.layout;
	compute_pipeline_create_info.flags = .CREATE_DESCRIPTOR_BUFFER_BIT_EXT;

	compute_pipeline_create_info.stage.stage = .COMPUTE_BIT;
	compute_pipeline_create_info.stage.module = ir;
	compute_pipeline_create_info.stage.pName = ir.entry_point.data;
	compute_pipeline_create_info.stage.pSpecializationInfo = null;
	
	
	vk_assert(vkCreateComputePipelines(device, VK_NULL_HANDLE, 1, *compute_pipeline_create_info, null, *pipeline.handle));

	return pipeline;
}

Shader_IR :: struct{
	#as handle: VkShaderModule;
	entry_point: string = "main";
}

gpu_generate_shader_ir :: (path: string, $entry_point: string = "main") -> Shader_IR {
	data, result := read_entire_file(path);
	assert(result, "Could not open file");

	create_info: VkShaderModuleCreateInfo;
    create_info.codeSize = xx data.count;
    create_info.pCode = xx data.data;
	
	ir: Shader_IR;
    vk_assert(vkCreateShaderModule(device, *create_info, null, *ir.handle));
	return ir;
}

#scope_file;


create_texture_heap_descriptor_set_layout :: () -> VkDescriptorSetLayout{
	layout_binding: [2]VkDescriptorSetLayoutBinding;
    layout_binding[0].binding = 0;
	layout_binding[0].descriptorType = .COMBINED_IMAGE_SAMPLER;
	layout_binding[0].descriptorCount = 65565;
	layout_binding[0].stageFlags = .ALL ;
	layout_binding[0].pImmutableSamplers = null;
	layout_binding[1].binding = 1;
	layout_binding[1].descriptorType = .STORAGE_IMAGE;
	layout_binding[1].descriptorCount = 65565;
	layout_binding[1].stageFlags = .COMPUTE_BIT;
	layout_binding[1].pImmutableSamplers = null;
	
	info: VkDescriptorSetLayoutCreateInfo;
	info.flags = .DESCRIPTOR_BUFFER_BIT_EXT;
	info.bindingCount = xx layout_binding.count;
	info.pBindings = layout_binding.data;
	
	layout: VkDescriptorSetLayout ;
	vkCreateDescriptorSetLayout(device, *info, null, *layout);

	descriptor_buffer_props: VkPhysicalDeviceDescriptorBufferPropertiesEXT;
	device_properties: VkPhysicalDeviceProperties2;
	device_properties.pNext = *descriptor_buffer_props;
	vkGetPhysicalDeviceProperties2(physical_device, *device_properties);


	descriptor_set_size: VkDeviceSize;
	get_instance_proc_add(instance, "vkGetDescriptorSetLayoutSizeEXT");
	vkGetDescriptorSetLayoutSizeEXT(device, layout, *descriptor_set_size);
	log("Size: % vs %", descriptor_set_size, align_to(xx (size_of(u64) * 65565), 64));

	get_instance_proc_add(instance, "vkGetDescriptorSetLayoutBindingOffsetEXT");
	binding_offset: u64;
	vkGetDescriptorSetLayoutBindingOffsetEXT(device, layout, 1, *binding_offset);
	log("%", binding_offset);
	return layout;
}
