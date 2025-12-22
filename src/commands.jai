Queue :: struct {
	#as handle: VkQueue = NULL_HANDLE;
	#as family_index: u32 = cast,no_check(u32, -1);

	pool: VkCommandPool = NULL_HANDLE;
	present: bool;
	alive_buffer: s32;
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

Command_Buffer :: struct {
	#as handle: VkCommandBuffer;
	current_pipeline: Pipeline;
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

gpu_bind_pipeline :: (buffer: *Command_Buffer, pipeline: Pipeline){
	buffer.current_pipeline = pipeline;
	vkCmdBindPipeline(buffer, xx pipeline.usage, pipeline);
}

gpu_dispatch :: (buffer: Command_Buffer, ptr: *void, x: u32, y: u32, z: u32) {
	device_address := cast(VkDeviceAddress, ptr);
	
	vkCmdPushConstants(buffer, buffer.current_pipeline.layout, .COMPUTE_BIT, 0, size_of(VkDeviceAddress), *device_address);
	vkCmdDispatch(buffer, x, y, z);
}

gpu_clear :: (buffer: Command_Buffer, image: *Texture,  color: Color4){
	layout := image.layout;
	transition_image_layout(buffer, image, .TRANSFER_DST_OPTIMAL);
	clear_range := create_subresource_range(xx VkImageAspectFlagBits.COLOR_BIT);
	clear_value: VkClearColorValue = .{.[color.r / 255.0, color.g / 255.0, color.b / 255.0, color.a / 255.0]};
	vkCmdClearColorImage(buffer, image, xx image.layout, *clear_value, 1, *clear_range);
	if layout != .UNDEFINED then transition_image_layout(buffer, image, layout);
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

	allocation := allocation_from_ptr(data);
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

gpu_bind_texture_heap :: (buffer: Command_Buffer, ptr: *void){	
	descriptor_buffer_binding_info: VkDescriptorBufferBindingInfoEXT;
	descriptor_buffer_binding_info.usage   = .SAMPLER_DESCRIPTOR_BUFFER_BIT_EXT;
	descriptor_buffer_binding_info.address = xx ptr;
	get_instance_proc_add(instance, "vkCmdBindDescriptorBuffersEXT");
	vkCmdBindDescriptorBuffersEXT(buffer, 1, *descriptor_buffer_binding_info);


	get_instance_proc_add(instance, "vkCmdSetDescriptorBufferOffsetsEXT");
	index: u32 = 0;
	offset: u64 = 0; //I have no clue what this offset represent
	vkCmdSetDescriptorBufferOffsetsEXT(buffer, xx buffer.current_pipeline.usage, buffer.current_pipeline.layout, 0, 1, *index, *offset);
}

gpu_present :: (buffer: Command_Buffer, queue: *Queue){
	queue.present = true;
	swapchain.current_sync = xx ((swapchain.current_sync + 1) % (swapchain.semaphores.count ));
	error := vkAcquireNextImageKHR(device, swapchain, U64_MAX, swapchain.semaphores[swapchain.current_sync], NULL_HANDLE, *swapchain.current_image);
	if error == VkResult.ERROR_OUT_OF_DATE_KHR return;
	transition_image_layout(buffer, *swapchain.images[swapchain.current_image], .PRESENT_SRC);
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
    image_barrier.srcAccessMask = VK_ACCESS_2_MEMORY_WRITE_BIT;
    image_barrier.dstStageMask = VK_PIPELINE_STAGE_2_ALL_COMMANDS_BIT;
    image_barrier.dstAccessMask = VK_ACCESS_2_MEMORY_WRITE_BIT  | VK_ACCESS_2_MEMORY_READ_BIT;
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
