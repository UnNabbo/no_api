Queue :: struct {
	#as handle: VkQueue = NULL_HANDLE;
	#as family_index: u32 = cast,no_check(u32, -1);

	pool: VkCommandPool = NULL_HANDLE;
	present: bool;
	alive_buffer: s32;
}

Command_Buffer :: struct {
	#as handle: VkCommandBuffer;
	current_pipeline: *Pipeline;
}


Attachment :: struct {
	Load_Op :: enum {
		LOAD :: 0;
		CLEAR :: 1;
		DONT_CARE :: 2;
		NONE :: 1000400000;
	}
	Store_Op :: enum {
		STORE :: 0;
		DONT_CARE :: 1;
		NONE :: 1000301000;
	}
		
	texture: *Texture = null;
	load_op: Load_Op  = .NONE;
	store_op: Store_Op = .NONE;
	
	clear_value: f32  = 0;
}

Render_Pass_Descriptor :: struct {
	depth_target: Attachment;
	stencil_target: Attachment;
	color_targets: [] Attachment;
}

gpu_create_queue :: (kind: Queue_Family.Kind) -> Queue {
	queue: Queue;
	for * device.created_queues {
		if it.kind == kind && it.used + 1 <= it.count {
			vkGetDeviceQueue(device, xx it.index,xx it.used, *queue.handle);
			queue.family_index = it.index;
			it.used += 1;
			
			command_pool_info: VkCommandPoolCreateInfo;
			command_pool_info.flags = .TRANSIENT_BIT;
			command_pool_info.queueFamilyIndex = it.index;
			vk_assert(vkCreateCommandPool(device, *command_pool_info, null, *queue.pool));
			
			return queue;
		}
	}
	return {};
}
gpu_start_command_recording :: (queue: *Queue) -> Command_Buffer{
	queue.alive_buffer += 1;
	command_buffer: Command_Buffer;
	
	command_buffer_info: VkCommandBufferAllocateInfo;
	command_buffer_info.commandPool = queue.pool;
	command_buffer_info.commandBufferCount = 1;
	command_buffer_info.level = .PRIMARY;

	vk_assert(vkAllocateCommandBuffers(device, *command_buffer_info, *command_buffer.handle));

	info: VkCommandBufferBeginInfo;
    info.flags = .ONE_TIME_SUBMIT_BIT;
	vk_assert(vkBeginCommandBuffer(command_buffer, *info));
	
	return command_buffer;
}

gpu_end_command_recording :: (buffer: Command_Buffer){
	vk_assert(vkEndCommandBuffer(buffer));
}

gpu_begin_render_pass :: (buffer: Command_Buffer, render_pass: Render_Pass_Descriptor) {
	render_info: VkRenderingInfo;

	width, height: u32;
	assert(render_pass.color_targets.count != 0, "Cannot begin a render pass without a single color target"); //NOTE: i dont' think there will ever be a case where you start a render pass without a color targer

	
    render_info.layerCount = 1;
	attachments := array_new(render_pass.color_targets.count, VkRenderingAttachmentInfo,, temp);
	for * render_pass.color_targets{
		assert(it.texture != null, "Attachment texture cannot be null");
		if it.texture.layout == .UNDEFINED then transition_image_layout(buffer, it.texture, .GENERAL);
		width = max(width, it.texture.extent.width);
		height = max(height, it.texture.extent.height);
		attachments[it_index] = to_vk_attachment(it);
	}

	if render_pass.depth_target.texture{
		if render_pass.depth_target.texture.layout == .UNDEFINED then transition_image_layout(buffer, render_pass.depth_target.texture, .DEPTH_ATTACHMENT_OPTIMAL);
	}
	
	render_info.renderArea = VkRect2D.{ VkOffset2D.{ 0, 0 }, .{width, height} };
    render_info.colorAttachmentCount = xx render_pass.color_targets.count;
    render_info.pColorAttachments = attachments.data;
	if render_pass.depth_target.texture then render_info.pDepthAttachment = *to_vk_attachment(render_pass.depth_target);
	if render_pass.stencil_target.texture then render_info.pStencilAttachment = *to_vk_attachment(render_pass.stencil_target);
	vkCmdBeginRendering(buffer, *render_info);
	gpu_bind_viewport(buffer, 0, 0, xx width, xx height);
	gpu_bind_scissor(buffer, 0, 0, width, height);
}

gpu_end_render_pass :: (buffer: Command_Buffer) {
	vkCmdEndRendering(buffer);
}

gpu_draw_indexed :: (buffer: Command_Buffer, vertex_data: *void, pixel_data: *void, indices: *$T, index_count: s64, instance_count: s64 = 1) {
	if vertex_data{
		vertex_address := cast(VkDeviceAddress, vertex_data);
		vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .VERTEX_BIT, 0, size_of(VkDeviceAddress), *vertex_address);
	}
	if pixel_data{
		pixel_address := cast(VkDeviceAddress, pixel_data);
		vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .FRAGMENT_BIT, size_of(VkDeviceAddress), size_of(VkDeviceAddress), *pixel_address);
	}

	allocation := get_cpu_metadata(indices);
	offset = cast(u64, indices) - allocation.base;
	vkCmdBindIndexBuffer(buffer, allocation.buffer, 0, ifx T == u32 then .UINT32 else .UINT16);
	vkCmdDrawIndexed(buffer, xx index_count, xx instance_count, offset, 0, 0);
}

gpu_draw_indexed_indirect :: (buffer: Command_Buffer, vertex_data: *void, pixel_data: *void, arguments: *void, draw_count: s64 = 1) {
	if vertex_data{
		vertex_address := cast(VkDeviceAddress, vertex_data);
		vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .VERTEX_BIT, 0, size_of(VkDeviceAddress), *vertex_address);
	}
	if pixel_data{
		pixel_address := cast(VkDeviceAddress, pixel_data);
		vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .FRAGMENT_BIT, size_of(VkDeviceAddress), size_of(VkDeviceAddress), *pixel_address);
	}

	allocation := get_gpu_metadata(arguments);
	vkCmdDrawIndexedIndirect(buffer, allocation.buffer, 0, xx draw_count, size_of(VkDrawIndexedIndirectCommand));
}

gpu_dispatch :: (buffer: Command_Buffer, ptr: *void, x: u32, y: u32, z: u32) {
	if ptr{
		device_address := cast(VkDeviceAddress, ptr);
		vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .COMPUTE_BIT, 0, size_of(VkDeviceAddress), *device_address);
	}
	vkCmdDispatch(buffer, x, y, z);
}

gpu_dispatch :: (buffer: Command_Buffer, ptr: *void, arguments: *void) {
	if ptr{
		device_address := cast(VkDeviceAddress, ptr);
		vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .COMPUTE_BIT, 0, size_of(VkDeviceAddress), *device_address);
	}
	
	allocation := get_gpu_metadata(arguments);
	vkCmdDispatchIndirect(buffer, allocation.buffer, 0);
}

gpu_bind_pipeline :: (buffer: *Command_Buffer, pipeline: *Pipeline){
	buffer.current_pipeline = pipeline;
	vkCmdBindPipeline(buffer, xx pipeline.usage, pipeline);
}

gpu_clear :: (buffer: Command_Buffer, image: *Texture,  color: Color4){
	layout := image.layout;
	transition_image_layout(buffer, image, .TRANSFER_DST_OPTIMAL);
	clear_range := create_subresource_range(xx VkImageAspectFlagBits.COLOR_BIT);
	clear_value: VkClearColorValue = .{.[color.r / 255.0, color.g / 255.0, color.b / 255.0, color.a / 255.0]};
	vkCmdClearColorImage(buffer, image, xx image.layout, *clear_value, 1, *clear_range);
	transition_image_layout(buffer, image, ifx layout == .UNDEFINED then .GENERAL else layout);
}

gpu_copy_to_texture :: (buffer: Command_Buffer, texture: *Texture, data: *void) {
	copy_region: VkBufferImageCopy;
	copy_region.bufferOffset = 0;
	copy_region.bufferRowLength = 0;
	copy_region.bufferImageHeight = 0;
	copy_region.imageSubresource.aspectMask = .COLOR_BIT;
	copy_region.imageSubresource.mipLevel = 0;
	copy_region.imageSubresource.baseArrayLayer = 0;
	copy_region.imageSubresource.layerCount = 1;
	copy_region.imageExtent = texture.extent;

	allocation := get_cpu_metadata(data);
	transition_image_layout(buffer, texture, .TRANSFER_DST_OPTIMAL);
	vkCmdCopyBufferToImage(buffer, allocation.buffer, texture, xx texture.layout, 1,  *copy_region);
}

gpu_blit_textures :: (buffer: Command_Buffer, source: *Texture, destination: *Texture) {
	source_layout := source.layout;
	destination_layout := destination.layout;
	
	transition_image_layout(buffer, source, .TRANSFER_SRC_OPTIMAL);
	transition_image_layout(buffer, destination, .TRANSFER_DST_OPTIMAL);
	
	blit_region: VkImageBlit2;
	blit_region.srcOffsets[1].x = xx source.extent.width;
	blit_region.srcOffsets[1].y = xx source.extent.height;
	blit_region.srcOffsets[1].z = 1;
	blit_region.dstOffsets[1].x = xx destination.extent.width;
	blit_region.dstOffsets[1].y = xx destination.extent.height;
	blit_region.dstOffsets[1].z = 1;
	blit_region.srcSubresource.aspectMask = .COLOR_BIT;
	blit_region.srcSubresource.baseArrayLayer = 0;
	blit_region.srcSubresource.layerCount = 1;
	blit_region.srcSubresource.mipLevel = 0;
	blit_region.dstSubresource.aspectMask = .COLOR_BIT;
	blit_region.dstSubresource.baseArrayLayer = 0;
	blit_region.dstSubresource.layerCount = 1;
	blit_region.dstSubresource.mipLevel = 0;
	
	blit_info: VkBlitImageInfo2;
	blit_info.dstImage = destination;
	blit_info.dstImageLayout = .TRANSFER_DST_OPTIMAL;
	blit_info.srcImage = source;
	blit_info.srcImageLayout = .TRANSFER_SRC_OPTIMAL;
	blit_info.filter = .LINEAR;
	blit_info.regionCount = 1;
	blit_info.pRegions = *blit_region;

	vkCmdBlitImage2(buffer, *blit_info);
 	
	if source_layout != .UNDEFINED then transition_image_layout(buffer, source, source_layout);
	if destination_layout != .UNDEFINED then transition_image_layout(buffer, destination, destination_layout);
}

gpu_set_depth_state :: ( buffer: Command_Buffer, using state: Depth_Stencil)
{
	if mode & .READ then vkCmdSetDepthTestEnable(buffer, xx true);
	if mode & .WRITE then vkCmdSetDepthWriteEnable(buffer, xx true);
	vkCmdSetDepthCompareOp(buffer, xx test);
	vkCmdSetDepthBias(buffer, bias, bias_clamp, bias_slope_factor);
	vkCmdSetStencilCompareMask(buffer, .FRONT_AND_BACK, xx read_mask);
	vkCmdSetStencilWriteMask(buffer, .FRONT_AND_BACK, xx write_mask);
	vkCmdSetStencilOp(buffer, .FACE_FRONT_BIT, xx front.fail, xx front.pass, xx front.depth_fail, xx front.test);
	vkCmdSetStencilReference(buffer, .FACE_FRONT_BIT, front.reference);
	vkCmdSetStencilOp(buffer, .FACE_BACK_BIT, xx back.fail, xx back.pass, xx back.depth_fail, xx back.test);
	vkCmdSetStencilReference(buffer, .FACE_BACK_BIT, back.reference);
}

gpu_set_blend_state :: (buffer: Command_Buffer, state: Blending_State)
{
    value: u32= xx true;
    vkCmdSetColorBlendEnableEXT(buffer, 0, 1, *value);
	equation : VkColorBlendEquationEXT;
    equation.srcColorBlendFactor = xx state.src_color_Factor;
    equation.dstColorBlendFactor = xx state.dst_color_Factor;
    equation.colorBlendOp        = xx state.color_op;
    equation.srcAlphaBlendFactor = xx state.src_alpha_factor;
    equation.dstAlphaBlendFactor = xx state.dst_alpha_factor;
    equation.alphaBlendOp        = xx state.alpha_op;
    vkCmdSetColorBlendEquationEXT(buffer, 0, 1, *equation);
    vkCmdSetColorWriteMaskEXT(buffer, 0, 1, xx state.write_mask);
}


gpu_bind_texture_heap :: (buffer: Command_Buffer, sampling_ptr: *void, rw_ptr: *void = null){
	if !sampling_ptr && !rw_ptr return;
	descriptor_buffer_binding_info: [2]VkDescriptorBufferBindingInfoEXT;
	descriptor_buffer_binding_info[0].usage   = .RESOURCE_DESCRIPTOR_BUFFER_BIT_EXT;
	descriptor_buffer_binding_info[1].usage   = .RESOURCE_DESCRIPTOR_BUFFER_BIT_EXT;
	if sampling_ptr then descriptor_buffer_binding_info[0].address =  xx gpu_host_to_device_address(sampling_ptr);
	if rw_ptr then descriptor_buffer_binding_info[1].address =  xx gpu_host_to_device_address(rw_ptr);
	vkCmdBindDescriptorBuffersEXT(buffer, xx ifx sampling_ptr && rw_ptr then 2 else 1, *descriptor_buffer_binding_info[ifx sampling_ptr then 0 else 1]);

	
	index: [2]u32 = .[0, 1]; offset: [2]u64 = .[0, 0]; 
	vkCmdSetDescriptorBufferOffsetsEXT(buffer, xx buffer.current_pipeline.usage, buffer.current_pipeline.layout,xx ifx sampling_ptr then 0 else 1, xx ifx sampling_ptr && rw_ptr then 2 else 1, index.data, offset.data);
}

gpu_present :: (buffer: Command_Buffer, queue: *Queue, image: *Texture) -> s32{
	queue.present = true;
	swapchain.current_sync = xx ((swapchain.current_sync + 1) % (swapchain.semaphores.count ));
	error := vkAcquireNextImageKHR(device, swapchain, U64_MAX, swapchain.semaphores[swapchain.current_sync], NULL_HANDLE, *swapchain.current_image);
	if error != VkResult.VK_SUCCESS return 1;
	gpu_blit_textures(buffer, image, *swapchain.images[swapchain.current_image]);
	transition_image_layout(buffer, *swapchain.images[swapchain.current_image], .PRESENT_SRC);
	return 0;
}

	
gpu_submit :: (queue: *Queue, semaphore: Semaphore, value: u64, buffers: ..Command_Buffer) {
	if !buffers.count return;
	buffer_info := array_new(buffers.count, VkCommandBufferSubmitInfo);
	for * buffer_info{
		queue.alive_buffer -= 1;
		it.commandBuffer = buffers[it_index];
	}
	submit2_info: VkSubmitInfo2;


#if false{
	wait_semaphore_info: VkSemaphoreSubmitInfo;
	wait_semaphore_info.semaphore = swapchain.semaphores[swapchain.current_sync];
	wait_semaphore_info.stageMask = VK_PIPELINE_STAGE_2_ALL_COMMANDS_BIT;
	submit2_info.waitSemaphoreInfoCount = 1;
	submit2_info.pWaitSemaphoreInfos = *wait_semaphore_info;

	render_semaphore := gpu_create_binary_semaphore();
}
	
	signal_semaphore_info: VkSemaphoreSubmitInfo;
	signal_semaphore_info.semaphore = semaphore;
	signal_semaphore_info.stageMask = VK_PIPELINE_STAGE_2_ALL_COMMANDS_BIT;
	signal_semaphore_info.value = value;
	
	submit2_info.signalSemaphoreInfoCount = 1;
	submit2_info.pSignalSemaphoreInfos = *signal_semaphore_info;
	
    submit2_info.commandBufferInfoCount = xx buffer_info.count;
    submit2_info.pCommandBufferInfos = buffer_info.data;

	
	vk_assert(vkQueueSubmit2(queue, 1, *submit2_info, VK_NULL_HANDLE));

	if queue.present {
		present_info: VkPresentInfoKHR;
		present_info.pSwapchains = *swapchain.handle;
		present_info.swapchainCount = 1;

		present_info.pWaitSemaphores = *swapchain.semaphores[swapchain.current_sync];
		//present_info.pWaitSemaphores = *render_semaphore.handle;
		present_info.waitSemaphoreCount = 1;

		present_info.pImageIndices = *swapchain.current_image;

		vkQueuePresentKHR(queue, *present_info);
		queue.present = false;
	}
	
	if !queue.alive_buffer{
		vkQueueWaitIdle(queue);
		//TODO bulk resett the pool
		buffer_handles := array_new(buffers.count, VkCommandBuffer);
		for * buffer_handles{
			it.* = buffers[it_index].handle;
		}
		vkFreeCommandBuffers(device, queue.pool, xx buffer_handles.count, buffer_handles.data);
	}
}

gpu_submit :: (queue: *Queue, buffers: ..Command_Buffer) {
	if !buffers.count return;

	buffer_info := array_new(buffers.count, VkCommandBufferSubmitInfo);
	for * buffer_info{
		queue.alive_buffer -= 1;
		it.commandBuffer = buffers[it_index];
	}
	submit2_info: VkSubmitInfo2;
    submit2_info.commandBufferInfoCount = xx buffer_info.count;
    submit2_info.pCommandBufferInfos = buffer_info.data;
	
	vk_assert(vkQueueSubmit2(queue, 1, *submit2_info, VK_NULL_HANDLE));

	if queue.present {
		present_info: VkPresentInfoKHR;
		present_info.pSwapchains = *swapchain.handle;
		present_info.swapchainCount = 1;

		present_info.pWaitSemaphores = *swapchain.semaphores[swapchain.current_sync];
		//present_info.pWaitSemaphores = *render_semaphore.handle;
		present_info.waitSemaphoreCount = 1;

		present_info.pImageIndices = *swapchain.current_image;

		vkQueuePresentKHR(queue, *present_info);
		queue.present = false;
	}
	
	if !queue.alive_buffer{
		vkQueueWaitIdle(queue);
		//TODO bulk resett the pool
		buffer_handles := array_new(buffers.count, VkCommandBuffer);
		for * buffer_handles{
			it.* = buffers[it_index].handle;
		}
		vkFreeCommandBuffers(device, queue.pool, xx buffer_handles.count, buffer_handles.data);
	}
}


gpu_bind_viewport :: (buffer: Command_Buffer, x: f32, y: f32, width: f32, height: f32, near: f32 = 0, far: f32 = 1) {
	view_port: VkViewport = .{x, y, width, height, near, far};
	vkCmdSetViewport(buffer, 0, 1, *view_port);
}

gpu_bind_scissor :: (buffer: Command_Buffer, x: s32, y: s32, width: u32, height: u32) {
	scissor: VkRect2D = .{{x, y}, {width, height}};
	vkCmdSetScissor(buffer, 0, 1, *scissor);
}


#scope_file;

create_subresource_range :: (mask: u64) -> VkImageSubresourceRange{
	subresource: VkImageSubresourceRange;
	subresource.aspectMask = xx mask;
	subresource.baseMipLevel = 0;
	subresource.levelCount = VK_REMAINING_MIP_LEVELS;
	subresource.baseArrayLayer = 0;
	subresource.layerCount = VK_REMAINING_ARRAY_LAYERS;
	return subresource;
}

transition_image_layout :: (command_buffer: Command_Buffer, image: *Texture, target_layout: Texture.Layout){
	if image.layout == target_layout then return;
	
	image_barrier: VkImageMemoryBarrier2;
    image_barrier.srcStageMask = VK_PIPELINE_STAGE_2_ALL_COMMANDS_BIT;
    image_barrier.srcAccessMask = ifx image.layout != .PRESENT_SRC then VK_ACCESS_2_TRANSFER_WRITE_BIT else VK_ACCESS_2_MEMORY_WRITE_BIT;
    image_barrier.dstStageMask = VK_PIPELINE_STAGE_2_ALL_COMMANDS_BIT;
    image_barrier.dstAccessMask =  ifx image.layout != .PRESENT_SRC then VK_ACCESS_2_TRANSFER_WRITE_BIT else VK_ACCESS_2_MEMORY_WRITE_BIT;
    image_barrier.oldLayout = xx image.layout;
    image_barrier.newLayout = xx target_layout;
	
    aspect_mask:  = ifx cast(u64, target_layout) == cast(u64, VkImageLayout.DEPTH_ATTACHMENT_OPTIMAL) then VkImageAspectFlagBits.DEPTH_BIT else VkImageAspectFlagBits.COLOR_BIT;

	sub_image := create_subresource_range(xx aspect_mask);
	
    image_barrier.subresourceRange = sub_image;
    image_barrier.image = image;

    dep_info: VkDependencyInfo;
    dep_info.imageMemoryBarrierCount = 1;
    dep_info.pImageMemoryBarriers = *image_barrier;

    vkCmdPipelineBarrier2(command_buffer, *dep_info);

	image.layout = target_layout;
}

to_vk_attachment :: (using attachment: Attachment) -> VkRenderingAttachmentInfo {
	vk_attachment: VkRenderingAttachmentInfo;
    vk_attachment.imageView = texture.view;
    vk_attachment.imageLayout = xx texture.layout;
    vk_attachment.storeOp = xx store_op;
	vk_attachment.loadOp = xx load_op;
	vk_attachment.clearValue.depthStencil.depth = clear_value;

	return vk_attachment;
}

