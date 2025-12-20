Pipeline :: struct{
	Kind :: enum {
		GRAPHICS               :: 0;
		COMPUTE                :: 1;
		RAY_TRACING            :: 1000165000; 
	}
	
	#as handle: VkPipeline;
	layout: VkPipelineLayout;
	
	usage: Kind;
}

//VkDeviceAddress 


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
	
	vk_assert(vkCreatePipelineLayout(device, *compute_layout, null, *pipeline.layout));

	compute_pipeline_create_info: VkComputePipelineCreateInfo;
	compute_pipeline_create_info.layout = pipeline.layout;
	compute_pipeline_create_info.stage;

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
