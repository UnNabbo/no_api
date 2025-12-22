Memory_Kind :: enum {
	DEFAULT;
	GPU;
	READBACK;
};

Texture_Descriptor :: u32; // Actual size is u64 as it is split in 2 handles, one for the sampler_image and the other for the raw image for compute work.



Texture :: struct{
		Usage :: enum_flags {
		NONE                                 :: 0x0;
		TRANSFER_SRC                         :: 0x1;
		TRANSFER_DST                         :: 0x2;
		SAMPLED                              :: 0x4;
		STORAGE                              :: 0x8;
		COLOR_ATTACHMENT                     :: 0x10;
		DEPTH_STENCIL_ATTACHMENT             :: 0x20;
		TRANSIENT_ATTACHMENT                 :: 0x40;
		INPUT_ATTACHMENT                     :: 0x80;
		VIDEO_DECODE_DST_KHR                 :: 0x400;
		VIDEO_DECODE_SRC_KHR                 :: 0x800;
		VIDEO_DECODE_DPB_KHR                 :: 0x1000;
		FRAGMENT_DENSITY_MAP_EXT             :: 0x200;
		FRAGMENT_SHADING_RATE_ATTACHMENT_KHR :: 0x100;
		HOST_TRANSFER_EXT                    :: 0x400000;
		VIDEO_ENCODE_DST_KHR                 :: 0x2000;
		VIDEO_ENCODE_SRC_KHR                 :: 0x4000;
		VIDEO_ENCODE_DPB_KHR                 :: 0x8000;
		ATTACHMENT_FEEDBACK_LOOP_EXT         :: 0x80000;
		INVOCATION_MASK_HUAWEI               :: 0x40000;
		SAMPLE_WEIGHT_QCOM                   :: 0x100000;
		SAMPLE_BLOCK_MATCH_QCOM              :: 0x200000;
		SHADING_RATE_IMAGE_NV                :: 0x100;
		FLAGS_MAX_ENUM                       :: 0x7fffffff;
	}
	
	Format :: enum u32 {
		UNDEFINED                                      :: 0;
		NONE :: UNDEFINED;
		R4G4_UNORM_PACK8                               :: 1;
		R4G4B4A4_UNORM_PACK16                          :: 2;
		B4G4R4A4_UNORM_PACK16                          :: 3;
		R5G6B5_UNORM_PACK16                            :: 4;
		B5G6R5_UNORM_PACK16                            :: 5;
		R5G5B5A1_UNORM_PACK16                          :: 6;
		B5G5R5A1_UNORM_PACK16                          :: 7;
		A1R5G5B5_UNORM_PACK16                          :: 8;
		R8_UNORM                                       :: 9;
		R8_SNORM                                       :: 10;
		R8_USCALED                                     :: 11;
		R8_SSCALED                                     :: 12;
		R8_UINT                                        :: 13;
		R8_SINT                                        :: 14;
		R8_SRGB                                        :: 15;
		R8G8_UNORM                                     :: 16;
		R8G8_SNORM                                     :: 17;
		R8G8_USCALED                                   :: 18;
		R8G8_SSCALED                                   :: 19;
		R8G8_UINT                                      :: 20;
		R8G8_SINT                                      :: 21;
		R8G8_SRGB                                      :: 22;
		R8G8B8_UNORM                                   :: 23;
		R8G8B8_SNORM                                   :: 24;
		R8G8B8_USCALED                                 :: 25;
		R8G8B8_SSCALED                                 :: 26;
		R8G8B8_UINT                                    :: 27;
		R8G8B8_SINT                                    :: 28;
		R8G8B8_SRGB                                    :: 29;
		B8G8R8_UNORM                                   :: 30;
		B8G8R8_SNORM                                   :: 31;
		B8G8R8_USCALED                                 :: 32;
		B8G8R8_SSCALED                                 :: 33;
		B8G8R8_UINT                                    :: 34;
		B8G8R8_SINT                                    :: 35;
		B8G8R8_SRGB                                    :: 36;
		R8G8B8A8_UNORM                                 :: 37;
		R8G8B8A8_SNORM                                 :: 38;
		R8G8B8A8_USCALED                               :: 39;
		R8G8B8A8_SSCALED                               :: 40;
		R8G8B8A8_UINT                                  :: 41;
		R8G8B8A8_SINT                                  :: 42;
		R8G8B8A8_SRGB                                  :: 43;
		B8G8R8A8_UNORM                                 :: 44;
		B8G8R8A8_SNORM                                 :: 45;
		B8G8R8A8_USCALED                               :: 46;
		B8G8R8A8_SSCALED                               :: 47;
		B8G8R8A8_UINT                                  :: 48;
		B8G8R8A8_SINT                                  :: 49;
		B8G8R8A8_SRGB                                  :: 50;
		A8B8G8R8_UNORM_PACK32                          :: 51;
		A8B8G8R8_SNORM_PACK32                          :: 52;
		A8B8G8R8_USCALED_PACK32                        :: 53;
		A8B8G8R8_SSCALED_PACK32                        :: 54;
		A8B8G8R8_UINT_PACK32                           :: 55;
		A8B8G8R8_SINT_PACK32                           :: 56;
		A8B8G8R8_SRGB_PACK32                           :: 57;
		A2R10G10B10_UNORM_PACK32                       :: 58;
		A2R10G10B10_SNORM_PACK32                       :: 59;
		A2R10G10B10_USCALED_PACK32                     :: 60;
		A2R10G10B10_SSCALED_PACK32                     :: 61;
		A2R10G10B10_UINT_PACK32                        :: 62;
		A2R10G10B10_SINT_PACK32                        :: 63;
		A2B10G10R10_UNORM_PACK32                       :: 64;
		A2B10G10R10_SNORM_PACK32                       :: 65;
		A2B10G10R10_USCALED_PACK32                     :: 66;
		A2B10G10R10_SSCALED_PACK32                     :: 67;
		A2B10G10R10_UINT_PACK32                        :: 68;
		A2B10G10R10_SINT_PACK32                        :: 69;
		R16_UNORM                                      :: 70;
		R16_SNORM                                      :: 71;
		R16_USCALED                                    :: 72;
		R16_SSCALED                                    :: 73;
		R16_UINT                                       :: 74;
		R16_SINT                                       :: 75;
		R16_SFLOAT                                     :: 76;
		R16G16_UNORM                                   :: 77;
		R16G16_SNORM                                   :: 78;
		R16G16_USCALED                                 :: 79;
		R16G16_SSCALED                                 :: 80;
		R16G16_UINT                                    :: 81;
		R16G16_SINT                                    :: 82;
		R16G16_SFLOAT                                  :: 83;
		R16G16B16_UNORM                                :: 84;
		R16G16B16_SNORM                                :: 85;
		R16G16B16_USCALED                              :: 86;
		R16G16B16_SSCALED                              :: 87;
		R16G16B16_UINT                                 :: 88;
		R16G16B16_SINT                                 :: 89;
		R16G16B16_SFLOAT                               :: 90;
		R16G16B16A16_UNORM                             :: 91;
		R16G16B16A16_SNORM                             :: 92;
		R16G16B16A16_USCALED                           :: 93;
		R16G16B16A16_SSCALED                           :: 94;
		R16G16B16A16_UINT                              :: 95;
		R16G16B16A16_SINT                              :: 96;
		R16G16B16A16_SFLOAT                            :: 97;
		R32_UINT                                       :: 98;
		R32_SINT                                       :: 99;
		R32_SFLOAT                                     :: 100;
		R32G32_UINT                                    :: 101;
		R32G32_SINT                                    :: 102;
		R32G32_SFLOAT                                  :: 103;
		R32G32B32_UINT                                 :: 104;
		R32G32B32_SINT                                 :: 105;
		R32G32B32_SFLOAT                               :: 106;
		R32G32B32A32_UINT                              :: 107;
		R32G32B32A32_SINT                              :: 108;
		R32G32B32A32_SFLOAT                            :: 109;
		R64_UINT                                       :: 110;
		R64_SINT                                       :: 111;
		R64_SFLOAT                                     :: 112;
		R64G64_UINT                                    :: 113;
		R64G64_SINT                                    :: 114;
		R64G64_SFLOAT                                  :: 115;
		R64G64B64_UINT                                 :: 116;
		R64G64B64_SINT                                 :: 117;
		R64G64B64_SFLOAT                               :: 118;
		R64G64B64A64_UINT                              :: 119;
		R64G64B64A64_SINT                              :: 120;
		R64G64B64A64_SFLOAT                            :: 121;
	}

	Layout :: enum{
		UNDEFINED                                      :: 0;
		GENERAL                                        :: 1;
		COLOR_ATTACHMENT_OPTIMAL                       :: 2;
		DEPTH_STENCIL_ATTACHMENT_OPTIMAL               :: 3;
		DEPTH_STENCIL_READ_ONLY_OPTIMAL                :: 4;
		SHADER_READ_ONLY_OPTIMAL                       :: 5;
		TRANSFER_SRC_OPTIMAL                           :: 6;
		TRANSFER_DST_OPTIMAL                           :: 7;
		PREINITIALIZED                                 :: 8;
		DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL     :: 1000117000;
		DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL     :: 1000117001;
		DEPTH_ATTACHMENT_OPTIMAL                       :: 1000241000;
		DEPTH_READ_ONLY_OPTIMAL                        :: 1000241001;
		STENCIL_ATTACHMENT_OPTIMAL                     :: 1000241002;
		STENCIL_READ_ONLY_OPTIMAL                      :: 1000241003;
		READ_ONLY_OPTIMAL                              :: 1000314000;
		ATTACHMENT_OPTIMAL                             :: 1000314001;
		PRESENT_SRC                                    :: 1000001002;
		VIDEO_DECODE_DST                               :: 1000024000;
		VIDEO_DECODE_SRC                               :: 1000024001;
		VIDEO_DECODE_DPB                               :: 1000024002;
		SHARED_PRESENT                                 :: 1000111000;
		FRAGMENT_DENSITY_MAP_OPTIMAL                   :: 1000218000;
		FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL       :: 1000164003;
		RENDERING_LOCAL_READ                           :: 1000232000;
		VIDEO_ENCODE_DST                               :: 1000299000;
		VIDEO_ENCODE_SRC                               :: 1000299001;
		VIDEO_ENCODE_DPB                               :: 1000299002;
		ATTACHMENT_FEEDBACK_LOOP_OPTIMAL               :: 1000339000;
	}
	
	#as handle: VkImage;
    using extent: VkExtent3D;
	view: VkImageView;
	layout : Layout;
	usage : Usage;
    format: Format;
	
	#as allocation: VmaAllocation;
	allocation_info: VmaAllocationInfo;
}

Texture_Info :: struct{
	width, height: u32;
	format: Texture.Format = .R8G8B8A8_UNORM;
	usage: Texture.Usage = .SAMPLED | .TRANSFER_DST | .TRANSFER_SRC;
}



gpu_malloc :: (size: s64, alignment: s64 = 16, kind: Memory_Kind = .DEFAULT, tag : string = "Untagged") -> *void {
	alloc_info: VmaAllocationCreateInfo ;
	alloc_info.usage = ifx kind != .GPU then .AUTO else .GPU_ONLY;
	alloc_info.flags = ifx kind != .GPU then .MAPPED_BIT | ifx kind == .DEFAULT then .HOST_ACCESS_SEQUENTIAL_WRITE_BIT;
	allocation: GPU_Allocation;
	allocation.size = xx size;

	buffer_info: VkBufferCreateInfo;
	buffer_info.size = cast(u64, size);
	buffer_info.usage = .SHADER_DEVICE_ADDRESS_BIT | .TRANSFER_SRC_BIT | .TRANSFER_DST_BIT | .SAMPLER_DESCRIPTOR_BUFFER_BIT_EXT;
	vk_assert(vmaCreateBuffer(device.allocator, *buffer_info, *alloc_info, *allocation.buffer, *allocation.handle, *allocation.info));

	ptr : * void = ifx kind != .GPU then allocation.info.pMappedData else xx allocation.handle;
	log("Allocated bytes % with tag % at address %", size, tag, ptr);
	table_add(*device.allocator.table, ptr, allocation);
	return ptr;
}

gpu_malloc :: (count: s64, $type: Type, kind: Memory_Kind = .DEFAULT, tag : string = "Untagged") -> *type{
	#if type == Texture_Descriptor {
		return gpu_malloc(xx align_to(xx (count * size_of(u64)), 128), align_of(u64), kind, tag);
	}else{
		return gpu_malloc(count * size_of(type), align_of(type), kind, tag);
	}
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


gpu_create_texture :: (using info: Texture_Info, kind: Memory_Kind = .GPU) ->  Texture{
	texture: Texture;
	texture.usage = usage;

	image_3d_extent: VkExtent3D = .{
		width,
		height,
		1
	};
	
	texture.format = format;
	texture.extent = image_3d_extent;

	image_info: VkImageCreateInfo;
    image_info.imageType = ._2D;
    image_info.format = xx texture.format;
    image_info.extent = texture.extent;
    image_info.mipLevels = 1;
    image_info.arrayLayers = 1;
    image_info.samples = ._1_BIT;
    image_info.tiling = .OPTIMAL;
    image_info.usage = xx texture.usage;
	
	alloc_info: VmaAllocationCreateInfo ;
	alloc_info.usage = ifx kind != .GPU then .AUTO else .GPU_ONLY;
	alloc_info.flags = ifx kind != .GPU then .MAPPED_BIT | ifx kind == .DEFAULT then .HOST_ACCESS_SEQUENTIAL_WRITE_BIT;

	vk_assert(vmaCreateImage(device.allocator, *image_info, *alloc_info, *texture.handle, *texture.allocation, *texture.allocation_info));

	view_info: VkImageViewCreateInfo;
    view_info.viewType = ._2D;
    view_info.image = texture;
    view_info.format = xx texture.format;
    view_info.subresourceRange.baseMipLevel = 0;
    view_info.subresourceRange.levelCount = 1;
    view_info.subresourceRange.baseArrayLayer = 0;
    view_info.subresourceRange.layerCount = 1;
	if texture.usage & .DEPTH_STENCIL_ATTACHMENT then view_info.subresourceRange.aspectMask = .DEPTH_BIT;
	else view_info.subresourceRange.aspectMask = .COLOR_BIT;


	vk_assert(vkCreateImageView(device, *view_info, null, *texture.view));
	
	return texture;
}

TEXTURE_HEAP_DIRECT_ADDRESSING :: true;

#if TEXTURE_HEAP_DIRECT_ADDRESSING {
	gpu_create_texture_heap :: (count: s64) -> *Texture_Descriptor, *Texture_Descriptor{
		data := gpu_malloc(count, Texture_Descriptor);
		return data, data + align_to(count, 32) / 2;
	}
	
	gpu_create_texture_view_descriptor :: (texture: Texture, ptr: *Texture_Descriptor){
		get_instance_proc_add(instance, "vkGetDescriptorEXT");

		get_info: VkDescriptorGetInfoEXT;
		get_info.type = .COMBINED_IMAGE_SAMPLER;

		sampler: VkSampler;
		sampler_info: VkSamplerCreateInfo ;
		sampler_info.magFilter = .NEAREST;
		sampler_info.minFilter = .NEAREST;
		vkCreateSampler(device, *sampler_info, null, *sampler);
	
	
		image_info: VkDescriptorImageInfo;
		image_info.imageView = texture.view;
		image_info.imageLayout = xx texture.layout;
		image_info.sampler = sampler;
		get_info.data = .{pCombinedImageSampler =  *image_info};

		vkGetDescriptorEXT(device, *get_info, 4, ptr);
	}

	gpu_create_rw_texture_view_descriptor :: (texture: Texture, ptr: *Texture_Descriptor){
		get_instance_proc_add(instance, "vkGetDescriptorEXT");
		get_info: VkDescriptorGetInfoEXT;
		get_info.type = .STORAGE_IMAGE;
	
		image_info: VkDescriptorImageInfo;
		image_info.imageView = texture.view;
		image_info.imageLayout = xx texture.layout;
		get_info.data = .{pStorageImage =  *image_info};

		vkGetDescriptorEXT(device, *get_info, 4, ptr);
	}
	
}else{
	gpu_create_texture_view_descriptor :: (texture: Texture, ptr: *Texture_Descriptor, index: s32){
		allocation := table_find_pointer(*device.allocator.table, ptr);
		destination: * void = cast(*Texture_Descriptor, ptr) + index;
		assert(allocation != null, "could not find a valid allocation");
		get_instance_proc_add(instance, "vkGetDescriptorEXT");

		get_info: VkDescriptorGetInfoEXT;
		get_info.type = .COMBINED_IMAGE_SAMPLER;

		sampler: VkSampler;
		sampler_info: VkSamplerCreateInfo ;
		sampler_info.magFilter = .NEAREST;
		sampler_info.minFilter = .NEAREST;
		vkCreateSampler(device, *sampler_info, null, *sampler);
	
	
		image_info: VkDescriptorImageInfo;
		image_info.imageView = texture.view;
		image_info.imageLayout = xx texture.layout;
		image_info.sampler = sampler;
		get_info.data = .{pCombinedImageSampler =  *image_info};

		vkGetDescriptorEXT(device, *get_info, 4, destination);
	}

	gpu_create_rw_texture_view_descriptor :: (texture: Texture, destination: *Texture_Descriptor, index: s32){
		allocation := table_find_pointer(*device.allocator.table, destination);
		get_instance_proc_add(instance, "vkGetDescriptorEXT");

		get_info: VkDescriptorGetInfoEXT;
		get_info.type = .STORAGE_IMAGE;
	
		image_info: VkDescriptorImageInfo;
		image_info.imageView = texture.view;
		image_info.imageLayout = xx texture.layout;
		get_info.data = .{pStorageImage =  *image_info};

		log("PTR: %", destination);
		vkGetDescriptorEXT(device, *get_info, 4, cast(*u8, destination) + allocation.size / 2);
	}
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

allocation_from_ptr :: (ptr: *void) -> *GPU_Allocation {
	return table_find_pointer(*device.allocator.table, ptr);
}
