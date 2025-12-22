Semaphore :: VkSemaphore;


Stage :: enum_flags u64 {
    NONE                                 :: 0x0;
    TOP_OF_PIPE                          :: 0x1;
    DRAW_INDIRECT                        :: 0x2;
    VERTEX_INPUT                         :: 0x4;
    VERTEX_SHADER                        :: 0x8;
    TESSELLATION_CONTROL_SHADER          :: 0x10;
    TESSELLATION_EVALUATION_SHADER       :: 0x20;
    GEOMETRY_SHADER                      :: 0x40;
    FRAGMENT_SHADER                      :: 0x80;
    EARLY_FRAGMENT_TESTS                 :: 0x100;
    LATE_FRAGMENT_TESTS                  :: 0x200;
    COLOR_ATTACHMENT_OUTPUT              :: 0x400;
    COMPUTE_SHADER                       :: 0x800;
    TRANSFER                             :: 0x1000;
    BOTTOM_OF_PIPE                       :: 0x2000;
    HOST                                 :: 0x4000;
    ALL_GRAPHICS                         :: 0x8000;
    ALL                                  :: 0x10000;
}

Hazard :: enum_flags u64 {
    NONE           :: 0x0;
	DRAW_ARGUMENTS :: 0x1;
	COLOR_BUFFER   :: 0x100;
	DEPTH_STENCIL  :: 0x200;
	DESCRIPTORS    :: VK_ACCESS_2_DESCRIPTOR_BUFFER_READ_BIT_EXT;
}

gpu_create_semaphore :: (initial_value: u64 = 0) -> Semaphore {
	timeline_create_info: VkSemaphoreTypeCreateInfo ;
	timeline_create_info.semaphoreType = .TIMELINE;
	timeline_create_info.initialValue = initial_value;

	create_info: VkSemaphoreCreateInfo ;
	create_info.pNext = *timeline_create_info;
	create_info.flags = 0;

	timeline_semaphore: Semaphore;
	vk_assert(vkCreateSemaphore(device, *create_info, null, *timeline_semaphore));
	return timeline_semaphore;
}

gpu_wait_semaphore :: (semaphore: Semaphore, value: u64 = 0) {
	wait_info: VkSemaphoreWaitInfo ;
	wait_info.semaphoreCount = 1;
	wait_info.pSemaphores = *semaphore;
	wait_info.pValues = *value;

	vkWaitSemaphores(device, *wait_info, U64_MAX);
}

gpu_destroy_semaphore :: (semaphore: Semaphore) {
	
}

gpu_create_binary_semaphore :: () -> Semaphore{
	semaphore: Semaphore;
	
	info: VkSemaphoreCreateInfo;
    //info.flags = flags;
	vk_assert(vkCreateSemaphore(device, *info, null, *semaphore));
	
	return semaphore;
}

gpu_barrier :: (buffer: Command_Buffer, before: Stage, after: Stage, hazards: Hazard = .NONE) {
	memory_barrier: VkMemoryBarrier2;
	memory_barrier.srcAccessMask = xx (ifx before == .TRANSFER then VK_ACCESS_2_TRANSFER_READ_BIT else VK_ACCESS_2_SHADER_WRITE_BIT);
	memory_barrier.srcStageMask  = xx before;
    memory_barrier.dstAccessMask = xx VK_ACCESS_2_SHADER_READ_BIT | (xx hazards);
    memory_barrier.dstStageMask  = xx after;

	info: VkDependencyInfo;
	info.memoryBarrierCount = 1;
	info.pMemoryBarriers = *memory_barrier;
	
	vkCmdPipelineBarrier2(buffer, *info);
}

Barrier :: VkEvent;

gpu_create_barrier :: () -> Barrier{
	barrier: Barrier;
	info: VkEventCreateInfo;
	vk_assert(vkCreateEvent(device, *info, null, *barrier));
	return barrier;
}

gpu_signal_after :: (buffer: Command_Buffer, stage: Stage, barrier: *Barrier){
	memory_barrier: VkMemoryBarrier2;
    memory_barrier.dstAccessMask = xx VK_ACCESS_2_SHADER_READ_BIT;
    memory_barrier.dstStageMask = xx stage;

	info: VkDependencyInfo;
	info.memoryBarrierCount = 1;
	info.pMemoryBarriers = *memory_barrier;
	
	vkCmdSetEvent2(buffer, barrier.*, *info);
}

gpu_wait_before :: (buffer: Command_Buffer, stage: Stage, barrier: *Barrier) {
 	memory_barrier: VkMemoryBarrier2;
	memory_barrier.srcAccessMask = xx VK_ACCESS_2_SHADER_WRITE_BIT;
	memory_barrier.srcStageMask  = xx stage;

	info: VkDependencyInfo;
	info.memoryBarrierCount = 1;
	info.pMemoryBarriers = *memory_barrier;
	vkCmdWaitEvents2(buffer, 1, barrier, *info);
	vkResetEvent(device, barrier.*);
}


destroy_semaphore :: (semaphore: Semaphore){
	vkDestroySemaphore(device, semaphore, null);
}
