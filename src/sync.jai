Semaphore :: struct {
	#as handle: VkSemaphore;
	binary := false;
}


gpu_create_semaphore :: (initial_value: u64 = 0) {
	
}

gpu_create_binary_semaphore :: () -> Semaphore{
	semaphore: Semaphore;
	semaphore.binary = true;
	
	info: VkSemaphoreCreateInfo;
    //info.flags = flags;
	vk_assert(vkCreateSemaphore(device, *info, null, *semaphore.handle));
	
	return semaphore;
}

destroy_semaphore :: (semaphore: Semaphore){
	vkDestroySemaphore(device, semaphore, null);
}
