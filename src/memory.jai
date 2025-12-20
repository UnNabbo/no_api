Memory_Kind :: enum {
	DEFAULT;
	GPU;
	READBACK;
};

gpu_malloc :: (size: s64, alignment: s64 = 16, kind: Memory_Kind = .DEFAULT) -> *void {
	buffer_info: VkBufferCreateInfo;
	buffer_info.size = cast(u64, size);
	buffer_info.usage = .SHADER_DEVICE_ADDRESS_BIT;

	alloc_info: VmaAllocationCreateInfo ;
	alloc_info.usage = .AUTO;
	alloc_info.flags = .MAPPED_BIT | ifx kind == .DEFAULT then .HOST_ACCESS_SEQUENTIAL_WRITE_BIT;
	allocation: GPU_Allocation;
	
	// allocate the buffer
	vk_assert(vmaCreateBuffer(device.allocator, *buffer_info, *alloc_info, *allocation.buffer, *allocation.handle, *allocation.info));
	ptr := allocation.info.pMappedData;
	allocation.size = xx size;
	table_add(*device.allocator.table, ptr, allocation);
	return ptr;
}

gpu_malloc :: (count: s64, $type: Type, kind: Memory_Kind = .DEFAULT) -> *type{
	return gpu_malloc(count * size_of(type), align_of(type), kind);
}

gpu_free :: (ptr: *void, loc := #caller_location){
	allocation := table_find_pointer(*device.allocator.table, ptr);
	vmaDestroyBuffer(device.allocator, allocation.buffer, allocation);
}

gpu_host_to_device_address :: (ptr: *void) -> *void{
	allocation := table_find_pointer(*device.allocator.table, ptr);
	device_adress_info: VkBufferDeviceAddressInfo;
	device_adress_info.buffer = allocation.buffer;
	return xx vkGetBufferDeviceAddress(device, *device_adress_info);
}

#scope_module;

GPU_Allocation :: struct {
	#as handle: VmaAllocation;
	info: VmaAllocationInfo;
	
	size: s64;
	buffer: VkBuffer;
}

GPU_Allocator :: struct{
	#as handle: VmaAllocator;
	table: Table(*void, GPU_Allocation);
}

create_gpu_allocator :: () -> GPU_Allocator{
	allocator: GPU_Allocator;

	allocator_info: VmaAllocatorCreateInfo;
    allocator_info.physicalDevice = physical_device;
    allocator_info.device = device;
    allocator_info.instance = instance;
    allocator_info.flags = .BUFFER_DEVICE_ADDRESS_BIT;
    vmaCreateAllocator(*allocator_info, *allocator.handle);
	return allocator;
}

