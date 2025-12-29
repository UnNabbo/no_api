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

Stencil :: struct {
	Compare_Op :: enum {
		NEVER :: 0;
		LESS :: 1;
		EQUAL :: 2;
		LESS_OR_EQUAL :: 3;
		GREATER :: 4;
		NOT_EQUAL :: 5;
		GREATER_OR_EQUAL :: 6;
		ALWAYS :: 7;
	}
 
	Op :: enum {
		KEEP :: 0;
		ZERO :: 1;
		REPLACE :: 2;
		INCREMENT_AND_CLAMP :: 3;
		DECREMENT_AND_CLAMP :: 4;
		INVERT : :5;
		INCREMENT_AND_WRAP :: 6;
		DECREMENT_AND_WRAP :: 7;
	}
 	
    test: Compare_Op = .ALWAYS;
    fail: Op = .KEEP;
    pass: Op = .KEEP;
    depth_fail: Op = .KEEP;
    reference: u8 = 0;
};


Depth_Stencil :: struct {
	Flags :: enum_flags {
		READ  :: 0x1;
		WRITE :: 0x2;
	}

    mode: Flags = 0;
    test: Stencil.Compare_Op = .ALWAYS;
    bias: f32 = 0.0;
    bias_slope_factor: f32 = 0.0;
    bias_clamp: f32 = 0.0;
    read_mask: u8 = 0xff;
    write_mask: u8 = 0xff;
    front: Stencil;
    back: Stencil;
};

Blending_State:: struct {
	Op :: enum {
		ADD;
		SUB;
		REV_SUB;
		MIN;
		MAX;
	}
	
	Factor :: enum  {
		ZERO                     :: 0;
		ONE                      :: 1;
		SRC_COLOR                :: 2;
		ONE_MINUS_SRC_COLOR      :: 3;
		DST_COLOR                :: 4;
		ONE_MINUS_DST_COLOR      :: 5;
		SRC_ALPHA                :: 6;
		ONE_MINUS_SRC_ALPHA      :: 7;
		DST_ALPHA                :: 8;
		ONE_MINUS_DST_ALPHA      :: 9;
		CONSTANT_COLOR           :: 10;
		ONE_MINUS_CONSTANT_COLOR :: 11;
		CONSTANT_ALPHA           :: 12;
		ONE_MINUS_CONSTANT_ALPHA :: 13;
		SRC_ALPHA_SATURATE       :: 14;
		SRC1_COLOR               :: 15;
		ONE_MINUS_SRC1_COLOR     :: 16;
		SRC1_ALPHA               :: 17;
		ONE_MINUS_SRC1_ALPHA     :: 18;
	}

    color_op: Op = .ADD;
    src_color_Factor: Factor = .SRC_ALPHA;
    dst_color_Factor: Factor = .ONE_MINUS_SRC_ALPHA;
	
    alpha_op: Op = .ADD;
    src_alpha_factor: Factor = .ONE;
    dst_alpha_factor: Factor = .ZERO;
	
    write_mask: u8 = 0xf;
};

Color_Target :: struct {
    format: Texture.Format = .NONE;
    write_mask: u8 = 0xf;
};

Shader_IR :: struct{
	#as handle: VkShaderModule;
	entry_point: string = "main";
}

Rasterizer_Descriptor :: struct {
	Topology :: enum{
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
		NONE :: -1;
		COUNTER_CLOCKWISE ::  0;
		CLOCKWISE         ::  1;
	} 
	
    sample_count: u8 = 1;

	alpha_to_coverage: bool = false;
    dual_source_blending: = false;

    cull: Cull = .NONE;
    topology: Topology = .TRIANGLE_LIST;
	
    depth_format: Texture.Format = .NONE;
    stencil_format: Texture.Format = .NONE;

    color_targets: [] Color_Target;
	blend_state: *Blending_State = null; // optional embedded blend state
};

gpu_create_graphic_pipeline :: (vertex: Shader_IR, fragment: Shader_IR, rasterizer: Rasterizer_Descriptor) -> Pipeline{
	pipeline: Pipeline;
	pipeline.usage = .GRAPHIC;
	
	input_assembly: VkPipelineInputAssemblyStateCreateInfo;
	input_assembly.topology   = xx rasterizer.topology;
    input_assembly.primitiveRestartEnable  = VK_FALSE;
		
	rasterization: VkPipelineRasterizationStateCreateInfo;
	rasterization.polygonMode = .FILL;
    rasterization.lineWidth = xx 1.0;
	rasterization.cullMode = xx ifx rasterizer.cull == .NONE then .NONE else .BACK_BIT;
    rasterization.frontFace = xx ifx rasterizer.cull == .NONE then Rasterizer_Descriptor.Cull.COUNTER_CLOCKWISE else rasterizer.cull;

	multisampling: VkPipelineMultisampleStateCreateInfo;
	if(rasterizer.sample_count > 1){
		
	}else{
		multisampling.sampleShadingEnable = VK_FALSE;
		multisampling.rasterizationSamples = ._1_BIT;
		multisampling.minSampleShading = 1.0;
		multisampling.pSampleMask = null;
		multisampling.alphaToCoverageEnable = VK_FALSE;
		multisampling.alphaToOneEnable = VK_FALSE;
	}

	color_blend_attachment: VkPipelineColorBlendAttachmentState;
	if rasterizer.blend_state{
		using rasterizer.blend_state;
		//color_blend_attachment.colorWriteMask = write_mask;
		color_blend_attachment.colorWriteMask = .R_BIT | .G_BIT | .B_BIT | .A_BIT;
		color_blend_attachment.blendEnable = VK_TRUE;
		
		color_blend_attachment.colorBlendOp = xx color_op;
		color_blend_attachment.srcColorBlendFactor = xx src_color_Factor;
		color_blend_attachment.dstColorBlendFactor = xx dst_color_Factor;
		
		color_blend_attachment.alphaBlendOp = xx alpha_op;
		color_blend_attachment.srcAlphaBlendFactor = xx src_alpha_factor;
		color_blend_attachment.dstAlphaBlendFactor = xx dst_alpha_factor;
	}else{
		color_blend_attachment.colorWriteMask = .R_BIT | .G_BIT | .B_BIT | .A_BIT;
		color_blend_attachment.blendEnable = VK_FALSE;
	}
	
	attachments := array_new(rasterizer.color_targets.count, VkFormat,, temp);
	for rasterizer.color_targets{
		attachments[it_index] = xx it.format;
	}
	render_info: VkPipelineRenderingCreateInfo;
	render_info.colorAttachmentCount = xx attachments.count;
    render_info.pColorAttachmentFormats = attachments.data;
	render_info.depthAttachmentFormat = xx rasterizer.depth_format;

	depth_stencil: VkPipelineDepthStencilStateCreateInfo;
	depth_stencil.depthTestEnable = xx (rasterizer.depth_format != .NONE);
	depth_stencil.depthWriteEnable = xx (rasterizer.depth_format != .NONE);
	depth_stencil.depthCompareOp = xx 0;
	depth_stencil.depthBoundsTestEnable = VK_FALSE;
	depth_stencil.stencilTestEnable = VK_FALSE;
	depth_stencil.front = .{};
	depth_stencil.back = .{};
	depth_stencil.minDepthBounds = 0.0;
	depth_stencil.maxDepthBounds = 1.0;


	layout: VkPipelineLayoutCreateInfo;
	texture_layout := create_texture_heap_descriptor_set_layout();
	layout.pSetLayouts = texture_layout.data;
	layout.setLayoutCount = xx texture_layout.count;
	
	push_constant_info: [2]VkPushConstantRange;
	push_constant_info[0].offset = 0;
	push_constant_info[0].size = xx size_of(VkDeviceAddress);
	push_constant_info[0].stageFlags = .VERTEX_BIT;
	push_constant_info[1].offset = xx size_of(VkDeviceAddress);
	push_constant_info[1].size = xx size_of(VkDeviceAddress);
	push_constant_info[1].stageFlags = .FRAGMENT_BIT;
	layout.pPushConstantRanges = push_constant_info.data;
	layout.pushConstantRangeCount = push_constant_info.count;
	
	vk_assert(vkCreatePipelineLayout(device, *layout, null, *pipeline.layout));
	
	viewport_state: VkPipelineViewportStateCreateInfo;
	viewport_state.viewportCount = 1;
	viewport_state.scissorCount = 1;

	color_blending: VkPipelineColorBlendStateCreateInfo;
	color_blending.logicOpEnable = VK_FALSE;
	color_blending.logicOp = .COPY;
	battachment := array_new(attachments.count, VkPipelineColorBlendAttachmentState);
	for 0..attachments.count - 1{
		battachment[it] = color_blend_attachment;
	}
	color_blending.attachmentCount = xx battachment.count;
	color_blending.pAttachments = battachment.data;

	vertex_input_info: VkPipelineVertexInputStateCreateInfo;

	shader_stages: [2]VkPipelineShaderStageCreateInfo;
	shader_stages[0].stage = .VERTEX_BIT;
	shader_stages[0].module = vertex;
	shader_stages[0].pName = vertex.entry_point.data;
	shader_stages[1].stage = .FRAGMENT_BIT;
	shader_stages[1].module = fragment;
	shader_stages[1].pName = fragment.entry_point.data;
	
	pipeline_info: VkGraphicsPipelineCreateInfo;
	pipeline_info.pNext = *render_info;
	pipeline_info.flags = .CREATE_DESCRIPTOR_BUFFER_BIT_EXT;
	pipeline_info.stageCount = xx shader_stages.count;
	pipeline_info.pStages = shader_stages.data;
	pipeline_info.pVertexInputState = *vertex_input_info;
	pipeline_info.pInputAssemblyState = *input_assembly;
	pipeline_info.pViewportState = *viewport_state;
	pipeline_info.pRasterizationState = *rasterization;
	pipeline_info.pMultisampleState = *multisampling;
	pipeline_info.pColorBlendState = *color_blending;
	pipeline_info.pDepthStencilState = *depth_stencil;
	pipeline_info.layout = pipeline.layout;

	state: [] VkDynamicState = .[.VIEWPORT, .SCISSOR, .DEPTH_BIAS, .BLEND_CONSTANTS , .STENCIL_COMPARE_MASK, .STENCIL_WRITE_MASK, .STENCIL_REFERENCE, .DEPTH_COMPARE_OP, .STENCIL_OP];

	dynamic_info: VkPipelineDynamicStateCreateInfo;
	dynamic_info.dynamicStateCount = xx state.count;
	dynamic_info.pDynamicStates = state.data;

	pipeline_info.pDynamicState = *dynamic_info;

	vkCreateGraphicsPipelines(device, VK_NULL_HANDLE, 1, *pipeline_info, null, *pipeline.handle);

	
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
	compute_layout.pSetLayouts = texture_layout.data;
	compute_layout.setLayoutCount = 2;
	
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

gpu_generate_shader_ir :: (path: string, $entry_point: string = "main") -> Shader_IR {
	data, result := read_entire_file(path);
	assert(result, "Could not open file");

	create_info: VkShaderModuleCreateInfo;
    create_info.codeSize = xx data.count;
    create_info.pCode = xx data.data;
	
	ir: Shader_IR;
	ir.entry_point = entry_point;
    vk_assert(vkCreateShaderModule(device, *create_info, null, *ir.handle));
	return ir;
}

#scope_file;

create_texture_heap_descriptor_set_layout :: () -> []VkDescriptorSetLayout{
	layout: = array_new(2, VkDescriptorSetLayout);
	
	{
		layout_binding: VkDescriptorSetLayoutBinding;
		layout_binding.binding = 0;
		layout_binding.descriptorType = .COMBINED_IMAGE_SAMPLER;
		layout_binding.descriptorCount = xx texture_heap_size;
		layout_binding.stageFlags = .ALL ;
		layout_binding.pImmutableSamplers = null;
	
		binding_flags: VkDescriptorBindingFlags = .VARIABLE_DESCRIPTOR_COUNT_BIT | .PARTIALLY_BOUND_BIT;

		extended_info: VkDescriptorSetLayoutBindingFlagsCreateInfo  = .{bindingCount = 1, pBindingFlags = *binding_flags};

		info: VkDescriptorSetLayoutCreateInfo;
		info.flags = .DESCRIPTOR_BUFFER_BIT_EXT;
		info.bindingCount = 1;
		info.pBindings = *layout_binding;
		info.pNext = *extended_info;
	
		vkCreateDescriptorSetLayout(device, *info, null, *layout[0]);
	}
	{
		layout_binding: VkDescriptorSetLayoutBinding;
		layout_binding.binding = 0;
		layout_binding.descriptorType = .STORAGE_IMAGE;
		layout_binding.descriptorCount = xx rwtexture_heap_size;
		layout_binding.stageFlags = .ALL ;
		layout_binding.pImmutableSamplers = null;
	
		binding_flags: VkDescriptorBindingFlags = .VARIABLE_DESCRIPTOR_COUNT_BIT | .PARTIALLY_BOUND_BIT;

		extended_info: VkDescriptorSetLayoutBindingFlagsCreateInfo  = .{bindingCount = 1, pBindingFlags = *binding_flags};

		info: VkDescriptorSetLayoutCreateInfo;
		info.flags = .DESCRIPTOR_BUFFER_BIT_EXT;
		info.bindingCount = 1;
		info.pBindings = *layout_binding;
		info.pNext = *extended_info;
	
		vkCreateDescriptorSetLayout(device, *info, null, *layout[1]);
	}
	

	return layout;
}
