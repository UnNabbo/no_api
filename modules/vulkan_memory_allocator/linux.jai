//
// This file was auto-generated using the following command:
//
// jai generate.jai
//



VMA_VULKAN_VERSION :: 1003000;

VMA_DEDICATED_ALLOCATION :: 1;

VMA_BIND_MEMORY2 :: 1;

VMA_MEMORY_BUDGET :: 1;

VMA_BUFFER_DEVICE_ADDRESS :: 1;

VMA_MEMORY_PRIORITY :: 1;

VMA_KHR_MAINTENANCE4 :: 1;

VMA_KHR_MAINTENANCE5 :: 1;

VMA_EXTERNAL_MEMORY :: 1;

VMA_STATS_STRING_ENABLED :: 1;

/// Flags for created #VmaAllocator.
VmaAllocatorCreateFlagBits :: enum_flags u32 {
    EXTERNALLY_SYNCHRONIZED_BIT    :: 0x1;

    KHR_DEDICATED_ALLOCATION_BIT   :: 0x2;

    KHR_BIND_MEMORY2_BIT           :: 0x4;

    EXT_MEMORY_BUDGET_BIT          :: 0x8;

    AMD_DEVICE_COHERENT_MEMORY_BIT :: 0x10;

    BUFFER_DEVICE_ADDRESS_BIT      :: 0x20;

    EXT_MEMORY_PRIORITY_BIT        :: 0x40;

    KHR_MAINTENANCE4_BIT           :: 0x80;

    KHR_MAINTENANCE5_BIT           :: 0x100;

    FLAG_BITS_MAX_ENUM             :: 0x7fffffff;

    VMA_ALLOCATOR_CREATE_EXTERNALLY_SYNCHRONIZED_BIT    :: EXTERNALLY_SYNCHRONIZED_BIT;

    VMA_ALLOCATOR_CREATE_KHR_DEDICATED_ALLOCATION_BIT   :: KHR_DEDICATED_ALLOCATION_BIT;

    VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT           :: KHR_BIND_MEMORY2_BIT;

    VMA_ALLOCATOR_CREATE_EXT_MEMORY_BUDGET_BIT          :: EXT_MEMORY_BUDGET_BIT;

    VMA_ALLOCATOR_CREATE_AMD_DEVICE_COHERENT_MEMORY_BIT :: AMD_DEVICE_COHERENT_MEMORY_BIT;

    VMA_ALLOCATOR_CREATE_BUFFER_DEVICE_ADDRESS_BIT      :: BUFFER_DEVICE_ADDRESS_BIT;

    VMA_ALLOCATOR_CREATE_EXT_MEMORY_PRIORITY_BIT        :: EXT_MEMORY_PRIORITY_BIT;

    VMA_ALLOCATOR_CREATE_KHR_MAINTENANCE4_BIT           :: KHR_MAINTENANCE4_BIT;

    VMA_ALLOCATOR_CREATE_KHR_MAINTENANCE5_BIT           :: KHR_MAINTENANCE5_BIT;

    VMA_ALLOCATOR_CREATE_FLAG_BITS_MAX_ENUM             :: FLAG_BITS_MAX_ENUM;
}

/// See #VmaAllocatorCreateFlagBits.
VmaAllocatorCreateFlags :: VmaAllocatorCreateFlagBits;

/// \brief Intended usage of the allocated memory.
VmaMemoryUsage :: enum u32 {
    UNKNOWN              :: 0;

    GPU_ONLY             :: 1;

    CPU_ONLY             :: 2;

    CPU_TO_GPU           :: 3;

    GPU_TO_CPU           :: 4;

    CPU_COPY             :: 5;

    GPU_LAZILY_ALLOCATED :: 6;

    AUTO                 :: 7;

    AUTO_PREFER_DEVICE   :: 8;

    AUTO_PREFER_HOST     :: 9;

    MAX_ENUM             :: 2147483647;

    VMA_MEMORY_USAGE_UNKNOWN              :: UNKNOWN;

    VMA_MEMORY_USAGE_GPU_ONLY             :: GPU_ONLY;

    VMA_MEMORY_USAGE_CPU_ONLY             :: CPU_ONLY;

    VMA_MEMORY_USAGE_CPU_TO_GPU           :: CPU_TO_GPU;

    VMA_MEMORY_USAGE_GPU_TO_CPU           :: GPU_TO_CPU;

    VMA_MEMORY_USAGE_CPU_COPY             :: CPU_COPY;

    VMA_MEMORY_USAGE_GPU_LAZILY_ALLOCATED :: GPU_LAZILY_ALLOCATED;

    VMA_MEMORY_USAGE_AUTO                 :: AUTO;

    VMA_MEMORY_USAGE_AUTO_PREFER_DEVICE   :: AUTO_PREFER_DEVICE;

    VMA_MEMORY_USAGE_AUTO_PREFER_HOST     :: AUTO_PREFER_HOST;

    VMA_MEMORY_USAGE_MAX_ENUM             :: MAX_ENUM;
}

/// Flags to be passed as VmaAllocationCreateInfo::flags.
VmaAllocationCreateFlagBits :: enum_flags u32 {
    DEDICATED_MEMORY_BIT                   :: 0x1;

    NEVER_ALLOCATE_BIT                     :: 0x2;

    MAPPED_BIT                             :: 0x4;

    USER_DATA_COPY_STRING_BIT              :: 0x20;

    UPPER_ADDRESS_BIT                      :: 0x40;

    DONT_BIND_BIT                          :: 0x80;

    WITHIN_BUDGET_BIT                      :: 0x100;

    CAN_ALIAS_BIT                          :: 0x200;

    HOST_ACCESS_SEQUENTIAL_WRITE_BIT       :: 0x400;

    HOST_ACCESS_RANDOM_BIT                 :: 0x800;

    HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT :: 0x1000;

    STRATEGY_MIN_MEMORY_BIT                :: 0x10000;

    STRATEGY_MIN_TIME_BIT                  :: 0x20000;

    STRATEGY_MIN_OFFSET_BIT                :: 0x40000;

    STRATEGY_BEST_FIT_BIT                  :: 0x10000;

    STRATEGY_FIRST_FIT_BIT                 :: 0x20000;

    STRATEGY_MASK                          :: 0x70000;

    FLAG_BITS_MAX_ENUM                     :: 0x7fffffff;

    VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT                   :: DEDICATED_MEMORY_BIT;

    VMA_ALLOCATION_CREATE_NEVER_ALLOCATE_BIT                     :: NEVER_ALLOCATE_BIT;

    VMA_ALLOCATION_CREATE_MAPPED_BIT                             :: MAPPED_BIT;

    VMA_ALLOCATION_CREATE_USER_DATA_COPY_STRING_BIT              :: USER_DATA_COPY_STRING_BIT;

    VMA_ALLOCATION_CREATE_UPPER_ADDRESS_BIT                      :: UPPER_ADDRESS_BIT;

    VMA_ALLOCATION_CREATE_DONT_BIND_BIT                          :: DONT_BIND_BIT;

    VMA_ALLOCATION_CREATE_WITHIN_BUDGET_BIT                      :: WITHIN_BUDGET_BIT;

    VMA_ALLOCATION_CREATE_CAN_ALIAS_BIT                          :: CAN_ALIAS_BIT;

    VMA_ALLOCATION_CREATE_HOST_ACCESS_SEQUENTIAL_WRITE_BIT       :: HOST_ACCESS_SEQUENTIAL_WRITE_BIT;

    VMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT                 :: HOST_ACCESS_RANDOM_BIT;

    VMA_ALLOCATION_CREATE_HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT :: HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT;

    VMA_ALLOCATION_CREATE_STRATEGY_MIN_MEMORY_BIT                :: STRATEGY_MIN_MEMORY_BIT;

    VMA_ALLOCATION_CREATE_STRATEGY_MIN_TIME_BIT                  :: STRATEGY_MIN_TIME_BIT;

    VMA_ALLOCATION_CREATE_STRATEGY_MIN_OFFSET_BIT                :: STRATEGY_MIN_OFFSET_BIT;

    VMA_ALLOCATION_CREATE_STRATEGY_BEST_FIT_BIT                  :: STRATEGY_BEST_FIT_BIT;

    VMA_ALLOCATION_CREATE_STRATEGY_FIRST_FIT_BIT                 :: STRATEGY_FIRST_FIT_BIT;

    VMA_ALLOCATION_CREATE_STRATEGY_MASK                          :: STRATEGY_MASK;

    VMA_ALLOCATION_CREATE_FLAG_BITS_MAX_ENUM                     :: FLAG_BITS_MAX_ENUM;
}

/// See #VmaAllocationCreateFlagBits.
VmaAllocationCreateFlags :: VmaAllocationCreateFlagBits;

/// Flags to be passed as VmaPoolCreateInfo::flags.
VmaPoolCreateFlagBits :: enum_flags u32 {
    IGNORE_BUFFER_IMAGE_GRANULARITY_BIT :: 0x2;

    LINEAR_ALGORITHM_BIT                :: 0x4;

    ALGORITHM_MASK                      :: 0x4;

    FLAG_BITS_MAX_ENUM                  :: 0x7fffffff;

    VMA_POOL_CREATE_IGNORE_BUFFER_IMAGE_GRANULARITY_BIT :: IGNORE_BUFFER_IMAGE_GRANULARITY_BIT;

    VMA_POOL_CREATE_LINEAR_ALGORITHM_BIT                :: LINEAR_ALGORITHM_BIT;

    VMA_POOL_CREATE_ALGORITHM_MASK                      :: ALGORITHM_MASK;

    VMA_POOL_CREATE_FLAG_BITS_MAX_ENUM                  :: FLAG_BITS_MAX_ENUM;
}

/// Flags to be passed as VmaPoolCreateInfo::flags. See #VmaPoolCreateFlagBits.
VmaPoolCreateFlags :: VmaPoolCreateFlagBits;

/// Flags to be passed as VmaDefragmentationInfo::flags.
VmaDefragmentationFlagBits :: enum_flags u32 {
    ALGORITHM_FAST_BIT      :: 0x1;

    ALGORITHM_BALANCED_BIT  :: 0x2;

    ALGORITHM_FULL_BIT      :: 0x4;

    ALGORITHM_EXTENSIVE_BIT :: 0x8;

    ALGORITHM_MASK          :: 0xf;

    BITS_MAX_ENUM           :: 0x7fffffff;

    VMA_DEFRAGMENTATION_FLAG_ALGORITHM_FAST_BIT      :: ALGORITHM_FAST_BIT;

    VMA_DEFRAGMENTATION_FLAG_ALGORITHM_BALANCED_BIT  :: ALGORITHM_BALANCED_BIT;

    VMA_DEFRAGMENTATION_FLAG_ALGORITHM_FULL_BIT      :: ALGORITHM_FULL_BIT;

    VMA_DEFRAGMENTATION_FLAG_ALGORITHM_EXTENSIVE_BIT :: ALGORITHM_EXTENSIVE_BIT;

    VMA_DEFRAGMENTATION_FLAG_ALGORITHM_MASK          :: ALGORITHM_MASK;

    VMA_DEFRAGMENTATION_FLAG_BITS_MAX_ENUM           :: BITS_MAX_ENUM;
}

/// See #VmaDefragmentationFlagBits.
VmaDefragmentationFlags :: VmaDefragmentationFlagBits;

/// Operation performed on single defragmentation move. See structure #VmaDefragmentationMove.
VmaDefragmentationMoveOperation :: enum u32 {
    COPY    :: 0;

    IGNORE  :: 1;

    DESTROY :: 2;

    VMA_DEFRAGMENTATION_MOVE_OPERATION_COPY    :: COPY;

    VMA_DEFRAGMENTATION_MOVE_OPERATION_IGNORE  :: IGNORE;

    VMA_DEFRAGMENTATION_MOVE_OPERATION_DESTROY :: DESTROY;
}

/// Flags to be passed as VmaVirtualBlockCreateInfo::flags.
VmaVirtualBlockCreateFlagBits :: enum_flags u32 {
    LINEAR_ALGORITHM_BIT :: 0x1;

    ALGORITHM_MASK       :: 0x1;

    FLAG_BITS_MAX_ENUM   :: 0x7fffffff;

    VMA_VIRTUAL_BLOCK_CREATE_LINEAR_ALGORITHM_BIT :: LINEAR_ALGORITHM_BIT;

    VMA_VIRTUAL_BLOCK_CREATE_ALGORITHM_MASK       :: ALGORITHM_MASK;

    VMA_VIRTUAL_BLOCK_CREATE_FLAG_BITS_MAX_ENUM   :: FLAG_BITS_MAX_ENUM;
}

/// Flags to be passed as VmaVirtualBlockCreateInfo::flags. See #VmaVirtualBlockCreateFlagBits.
VmaVirtualBlockCreateFlags :: VmaVirtualBlockCreateFlagBits;

/// Flags to be passed as VmaVirtualAllocationCreateInfo::flags.
VmaVirtualAllocationCreateFlagBits :: enum_flags u32 {
    UPPER_ADDRESS_BIT       :: 0x40;

    STRATEGY_MIN_MEMORY_BIT :: 0x10000;

    STRATEGY_MIN_TIME_BIT   :: 0x20000;

    STRATEGY_MIN_OFFSET_BIT :: 0x40000;

    STRATEGY_MASK           :: 0x70000;

    FLAG_BITS_MAX_ENUM      :: 0x7fffffff;

    VMA_VIRTUAL_ALLOCATION_CREATE_UPPER_ADDRESS_BIT       :: UPPER_ADDRESS_BIT;

    VMA_VIRTUAL_ALLOCATION_CREATE_STRATEGY_MIN_MEMORY_BIT :: STRATEGY_MIN_MEMORY_BIT;

    VMA_VIRTUAL_ALLOCATION_CREATE_STRATEGY_MIN_TIME_BIT   :: STRATEGY_MIN_TIME_BIT;

    VMA_VIRTUAL_ALLOCATION_CREATE_STRATEGY_MIN_OFFSET_BIT :: STRATEGY_MIN_OFFSET_BIT;

    VMA_VIRTUAL_ALLOCATION_CREATE_STRATEGY_MASK           :: STRATEGY_MASK;

    VMA_VIRTUAL_ALLOCATION_CREATE_FLAG_BITS_MAX_ENUM      :: FLAG_BITS_MAX_ENUM;
}

/// Flags to be passed as VmaVirtualAllocationCreateInfo::flags. See #VmaVirtualAllocationCreateFlagBits.
VmaVirtualAllocationCreateFlags :: VmaVirtualAllocationCreateFlagBits;

VmaAllocator_T :: struct {}
VmaAllocator :: *VmaAllocator_T;

VmaPool_T :: struct {}
VmaPool :: *VmaPool_T;

VmaAllocation_T :: struct {}
VmaAllocation :: *VmaAllocation_T;

VmaDefragmentationContext_T :: struct {}
VmaDefragmentationContext :: *VmaDefragmentationContext_T;

VmaVirtualAllocation_T :: struct {}
VmaVirtualAllocation :: *VmaVirtualAllocation_T;

VmaVirtualBlock_T :: struct {}
VmaVirtualBlock :: *VmaVirtualBlock_T;

/// Callback function called after successful vkAllocateMemory.
PFN_vmaAllocateDeviceMemoryFunction :: #type (allocator: VmaAllocator, memoryType: u32, memory: VkDeviceMemory, size: VkDeviceSize, pUserData: *void) -> void #c_call;

/// Callback function called before vkFreeMemory.
PFN_vmaFreeDeviceMemoryFunction :: #type (allocator: VmaAllocator, memoryType: u32, memory: VkDeviceMemory, size: VkDeviceSize, pUserData: *void) -> void #c_call;

/** \brief Set of callbacks that the library will call for `vkAllocateMemory` and `vkFreeMemory`.

Provided for informative purpose, e.g. to gather statistics about number of
allocations or total amount of memory allocated in Vulkan.

Used in VmaAllocatorCreateInfo::pDeviceMemoryCallbacks.
*/
VmaDeviceMemoryCallbacks :: struct {
    /// Optional, can be null.
    pfnAllocate: PFN_vmaAllocateDeviceMemoryFunction;

    /// Optional, can be null.
    pfnFree:     PFN_vmaFreeDeviceMemoryFunction;

    /// Optional, can be null.
    pUserData:   *void;
}

/** \brief Pointers to some Vulkan functions - a subset used by the library.

Used in VmaAllocatorCreateInfo::pVulkanFunctions.
*/
VmaVulkanFunctions :: struct {
    /// Required when using VMA_DYNAMIC_VULKAN_FUNCTIONS.
    vkGetInstanceProcAddr:                   PFN_vkGetInstanceProcAddr;

    /// Required when using VMA_DYNAMIC_VULKAN_FUNCTIONS.
    vkGetDeviceProcAddr:                     PFN_vkGetDeviceProcAddr;
    vkGetPhysicalDeviceProperties:           PFN_vkGetPhysicalDeviceProperties;
    vkGetPhysicalDeviceMemoryProperties:     PFN_vkGetPhysicalDeviceMemoryProperties;
    vkAllocateMemory:                        PFN_vkAllocateMemory;
    vkFreeMemory:                            PFN_vkFreeMemory;
    vkMapMemory:                             PFN_vkMapMemory;
    vkUnmapMemory:                           PFN_vkUnmapMemory;
    vkFlushMappedMemoryRanges:               PFN_vkFlushMappedMemoryRanges;
    vkInvalidateMappedMemoryRanges:          PFN_vkInvalidateMappedMemoryRanges;
    vkBindBufferMemory:                      PFN_vkBindBufferMemory;
    vkBindImageMemory:                       PFN_vkBindImageMemory;
    vkGetBufferMemoryRequirements:           PFN_vkGetBufferMemoryRequirements;
    vkGetImageMemoryRequirements:            PFN_vkGetImageMemoryRequirements;
    vkCreateBuffer:                          PFN_vkCreateBuffer;
    vkDestroyBuffer:                         PFN_vkDestroyBuffer;
    vkCreateImage:                           PFN_vkCreateImage;
    vkDestroyImage:                          PFN_vkDestroyImage;
    vkCmdCopyBuffer:                         PFN_vkCmdCopyBuffer;

    /// Fetch "vkGetBufferMemoryRequirements2" on Vulkan >= 1.1, fetch "vkGetBufferMemoryRequirements2KHR" when using VK_KHR_dedicated_allocation extension.
    vkGetBufferMemoryRequirements2KHR:       PFN_vkGetBufferMemoryRequirements2KHR;

    /// Fetch "vkGetImageMemoryRequirements2" on Vulkan >= 1.1, fetch "vkGetImageMemoryRequirements2KHR" when using VK_KHR_dedicated_allocation extension.
    vkGetImageMemoryRequirements2KHR:        PFN_vkGetImageMemoryRequirements2KHR;

    /// Fetch "vkBindBufferMemory2" on Vulkan >= 1.1, fetch "vkBindBufferMemory2KHR" when using VK_KHR_bind_memory2 extension.
    vkBindBufferMemory2KHR:                  PFN_vkBindBufferMemory2KHR;

    /// Fetch "vkBindImageMemory2" on Vulkan >= 1.1, fetch "vkBindImageMemory2KHR" when using VK_KHR_bind_memory2 extension.
    vkBindImageMemory2KHR:                   PFN_vkBindImageMemory2KHR;

    /// Fetch from "vkGetPhysicalDeviceMemoryProperties2" on Vulkan >= 1.1, but you can also fetch it from "vkGetPhysicalDeviceMemoryProperties2KHR" if you enabled extension VK_KHR_get_physical_device_properties2.
    vkGetPhysicalDeviceMemoryProperties2KHR: PFN_vkGetPhysicalDeviceMemoryProperties2KHR;

    /// Fetch from "vkGetDeviceBufferMemoryRequirements" on Vulkan >= 1.3, but you can also fetch it from "vkGetDeviceBufferMemoryRequirementsKHR" if you enabled extension VK_KHR_maintenance4.
    vkGetDeviceBufferMemoryRequirements:     PFN_vkGetDeviceBufferMemoryRequirementsKHR;

    /// Fetch from "vkGetDeviceImageMemoryRequirements" on Vulkan >= 1.3, but you can also fetch it from "vkGetDeviceImageMemoryRequirementsKHR" if you enabled extension VK_KHR_maintenance4.
    vkGetDeviceImageMemoryRequirements:      PFN_vkGetDeviceImageMemoryRequirementsKHR;
}

/// Description of a Allocator to be created.
VmaAllocatorCreateInfo :: struct {
    /// Flags for created allocator. Use #VmaAllocatorCreateFlagBits enum.
    flags:                          VmaAllocatorCreateFlags;

    /// Vulkan physical device.
    /** It must be valid throughout whole lifetime of created allocator. */
    physicalDevice:                 VkPhysicalDevice;

    /// Vulkan device.
    /** It must be valid throughout whole lifetime of created allocator. */
    device:                         VkDevice;

    /// Preferred size of a single `VkDeviceMemory` block to be allocated from large heaps > 1 GiB. Optional.
    /** Set to 0 to use default, which is currently 256 MiB. */
    preferredLargeHeapBlockSize:    VkDeviceSize;

    /// Custom CPU memory allocation callbacks. Optional.
    /** Optional, can be null. When specified, will also be used for all CPU-side memory allocations. */
    pAllocationCallbacks:           *VkAllocationCallbacks;

    /// Informative callbacks for `vkAllocateMemory`, `vkFreeMemory`. Optional.
    /** Optional, can be null. */
    pDeviceMemoryCallbacks:         *VmaDeviceMemoryCallbacks;

    /** \brief Either null or a pointer to an array of limits on maximum number of bytes that can be allocated out of particular Vulkan memory heap.
    
    If not NULL, it must be a pointer to an array of
    `VkPhysicalDeviceMemoryProperties::memoryHeapCount` elements, defining limit on
    maximum number of bytes that can be allocated out of particular Vulkan memory
    heap.
    
    Any of the elements may be equal to `VK_WHOLE_SIZE`, which means no limit on that
    heap. This is also the default in case of `pHeapSizeLimit` = NULL.
    
    If there is a limit defined for a heap:
    
    - If user tries to allocate more memory from that heap using this allocator,
    the allocation fails with `VK_ERROR_OUT_OF_DEVICE_MEMORY`.
    - If the limit is smaller than heap size reported in `VkMemoryHeap::size`, the
    value of this limit will be reported instead when using vmaGetMemoryProperties().
    
    Warning! Using this feature may not be equivalent to installing a GPU with
    smaller amount of memory, because graphics driver doesn't necessary fail new
    allocations with `VK_ERROR_OUT_OF_DEVICE_MEMORY` result when memory capacity is
    exceeded. It may return success and just silently migrate some device memory
    blocks to system RAM. This driver behavior can also be controlled using
    VK_AMD_memory_overallocation_behavior extension.
    */
    pHeapSizeLimit:                 *VkDeviceSize;

    /** \brief Pointers to Vulkan functions. Can be null.
    
    For details see [Pointers to Vulkan functions](@ref config_Vulkan_functions).
    */
    pVulkanFunctions:               *VmaVulkanFunctions;

    /** \brief Handle to Vulkan instance object.
    
    Starting from version 3.0.0 this member is no longer optional, it must be set!
    */
    instance:                       VkInstance;

    /** \brief Optional. Vulkan version that the application uses.
    
    It must be a value in the format as created by macro `VK_MAKE_VERSION` or a constant like: `VK_API_VERSION_1_1`, `VK_API_VERSION_1_0`.
    The patch version number specified is ignored. Only the major and minor versions are considered.
    Only versions 1.0, 1.1, 1.2, 1.3 are supported by the current implementation.
    Leaving it initialized to zero is equivalent to `VK_API_VERSION_1_0`.
    It must match the Vulkan version used by the application and supported on the selected physical device,
    so it must be no higher than `VkApplicationInfo::apiVersion` passed to `vkCreateInstance`
    and no higher than `VkPhysicalDeviceProperties::apiVersion` found on the physical device used.
    */
    vulkanApiVersion:               u32;

    /** \brief Either null or a pointer to an array of external memory handle types for each Vulkan memory type.
    
    If not NULL, it must be a pointer to an array of `VkPhysicalDeviceMemoryProperties::memoryTypeCount`
    elements, defining external memory handle types of particular Vulkan memory type,
    to be passed using `VkExportMemoryAllocateInfoKHR`.
    
    Any of the elements may be equal to 0, which means not to use `VkExportMemoryAllocateInfoKHR` on this memory type.
    This is also the default in case of `pTypeExternalMemoryHandleTypes` = NULL.
    */
    pTypeExternalMemoryHandleTypes: *VkExternalMemoryHandleTypeFlagsKHR;
}

/// Information about existing #VmaAllocator object.
VmaAllocatorInfo :: struct {
    /** \brief Handle to Vulkan instance object.
    
    This is the same value as has been passed through VmaAllocatorCreateInfo::instance.
    */
    instance:       VkInstance;

    /** \brief Handle to Vulkan physical device object.
    
    This is the same value as has been passed through VmaAllocatorCreateInfo::physicalDevice.
    */
    physicalDevice: VkPhysicalDevice;

    /** \brief Handle to Vulkan device object.
    
    This is the same value as has been passed through VmaAllocatorCreateInfo::device.
    */
    device:         VkDevice;
}

/** \brief Calculated statistics of memory usage e.g. in a specific memory type, heap, custom pool, or total.

These are fast to calculate.
See functions: vmaGetHeapBudgets(), vmaGetPoolStatistics().
*/
VmaStatistics :: struct {
    /** \brief Number of `VkDeviceMemory` objects - Vulkan memory blocks allocated.
    */
    blockCount:      u32;

    /** \brief Number of #VmaAllocation objects allocated.
    
    Dedicated allocations have their own blocks, so each one adds 1 to `allocationCount` as well as `blockCount`.
    */
    allocationCount: u32;

    /** \brief Number of bytes allocated in `VkDeviceMemory` blocks.
    
    \note To avoid confusion, please be aware that what Vulkan calls an "allocation" - a whole `VkDeviceMemory` object
    (e.g. as in `VkPhysicalDeviceLimits::maxMemoryAllocationCount`) is called a "block" in VMA, while VMA calls
    "allocation" a #VmaAllocation object that represents a memory region sub-allocated from such block, usually for a single buffer or image.
    */
    blockBytes:      VkDeviceSize;

    /** \brief Total number of bytes occupied by all #VmaAllocation objects.
    
    Always less or equal than `blockBytes`.
    Difference `(blockBytes - allocationBytes)` is the amount of memory allocated from Vulkan
    but unused by any #VmaAllocation.
    */
    allocationBytes: VkDeviceSize;
}

/** \brief More detailed statistics than #VmaStatistics.

These are slower to calculate. Use for debugging purposes.
See functions: vmaCalculateStatistics(), vmaCalculatePoolStatistics().

Previous version of the statistics API provided averages, but they have been removed
because they can be easily calculated as:

\code
VkDeviceSize allocationSizeAvg = detailedStats.statistics.allocationBytes / detailedStats.statistics.allocationCount;
VkDeviceSize unusedBytes = detailedStats.statistics.blockBytes - detailedStats.statistics.allocationBytes;
VkDeviceSize unusedRangeSizeAvg = unusedBytes / detailedStats.unusedRangeCount;
\endcode
*/
VmaDetailedStatistics :: struct {
    /// Basic statistics.
    statistics:         VmaStatistics;

    /// Number of free ranges of memory between allocations.
    unusedRangeCount:   u32;

    /// Smallest allocation size. `VK_WHOLE_SIZE` if there are 0 allocations.
    allocationSizeMin:  VkDeviceSize;

    /// Largest allocation size. 0 if there are 0 allocations.
    allocationSizeMax:  VkDeviceSize;

    /// Smallest empty range size. `VK_WHOLE_SIZE` if there are 0 empty ranges.
    unusedRangeSizeMin: VkDeviceSize;

    /// Largest empty range size. 0 if there are 0 empty ranges.
    unusedRangeSizeMax: VkDeviceSize;
}

/** \brief  General statistics from current state of the Allocator -
total memory usage across all memory heaps and types.

These are slower to calculate. Use for debugging purposes.
See function vmaCalculateStatistics().
*/
VmaTotalStatistics :: struct {
    memoryType: [32] VmaDetailedStatistics;
    memoryHeap: [16] VmaDetailedStatistics;
    total:      VmaDetailedStatistics;
}

/** \brief Statistics of current memory usage and available budget for a specific memory heap.

These are fast to calculate.
See function vmaGetHeapBudgets().
*/
VmaBudget :: struct {
    /** \brief Statistics fetched from the library.
    */
    statistics: VmaStatistics;

    /** \brief Estimated current memory usage of the program, in bytes.
    
    Fetched from system using VK_EXT_memory_budget extension if enabled.
    
    It might be different than `statistics.blockBytes` (usually higher) due to additional implicit objects
    also occupying the memory, like swapchain, pipelines, descriptor heaps, command buffers, or
    `VkDeviceMemory` blocks allocated outside of this library, if any.
    */
    usage:      VkDeviceSize;

    /** \brief Estimated amount of memory available to the program, in bytes.
    
    Fetched from system using VK_EXT_memory_budget extension if enabled.
    
    It might be different (most probably smaller) than `VkMemoryHeap::size[heapIndex]` due to factors
    external to the program, decided by the operating system.
    Difference `budget - usage` is the amount of additional memory that can probably
    be allocated without problems. Exceeding the budget may result in various problems.
    */
    budget:     VkDeviceSize;
}

/** \brief Parameters of new #VmaAllocation.

To be used with functions like vmaCreateBuffer(), vmaCreateImage(), and many others.
*/
VmaAllocationCreateInfo :: struct {
    /// Use #VmaAllocationCreateFlagBits enum.
    flags:          VmaAllocationCreateFlags;

    /** \brief Intended usage of memory.
    
    You can leave #VMA_MEMORY_USAGE_UNKNOWN if you specify memory requirements in other way. \n
    If `pool` is not null, this member is ignored.
    */
    usage:          VmaMemoryUsage;

    /** \brief Flags that must be set in a Memory Type chosen for an allocation.
    
    Leave 0 if you specify memory requirements in other way. \n
    If `pool` is not null, this member is ignored.*/
    requiredFlags:  VkMemoryPropertyFlags;

    /** \brief Flags that preferably should be set in a memory type chosen for an allocation.
    
    Set to 0 if no additional flags are preferred. \n
    If `pool` is not null, this member is ignored. */
    preferredFlags: VkMemoryPropertyFlags;

    /** \brief Bitmask containing one bit set for every memory type acceptable for this allocation.
    
    Value 0 is equivalent to `UINT32_MAX` - it means any memory type is accepted if
    it meets other requirements specified by this structure, with no further
    restrictions on memory type index. \n
    If `pool` is not null, this member is ignored.
    */
    memoryTypeBits: u32;

    /** \brief Pool that this allocation should be created in.
    
    Leave `VK_NULL_HANDLE` to allocate from default pool. If not null, members:
    `usage`, `requiredFlags`, `preferredFlags`, `memoryTypeBits` are ignored.
    */
    pool:           VmaPool;

    /** \brief Custom general-purpose pointer that will be stored in #VmaAllocation, can be read as VmaAllocationInfo::pUserData and changed using vmaSetAllocationUserData().
    
    If #VMA_ALLOCATION_CREATE_USER_DATA_COPY_STRING_BIT is used, it must be either
    null or pointer to a null-terminated string. The string will be then copied to
    internal buffer, so it doesn't need to be valid after allocation call.
    */
    pUserData:      *void;

    /** \brief A floating-point value between 0 and 1, indicating the priority of the allocation relative to other memory allocations.
    
    It is used only when #VMA_ALLOCATOR_CREATE_EXT_MEMORY_PRIORITY_BIT flag was used during creation of the #VmaAllocator object
    and this allocation ends up as dedicated or is explicitly forced as dedicated using #VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT.
    Otherwise, it has the priority of a memory block where it is placed and this variable is ignored.
    */
    priority:       float;
}

/// Describes parameter of created #VmaPool.
VmaPoolCreateInfo :: struct {
    /** \brief Vulkan memory type index to allocate this pool from.
    */
    memoryTypeIndex:        u32;

    /** \brief Use combination of #VmaPoolCreateFlagBits.
    */
    flags:                  VmaPoolCreateFlags;

    /** \brief Size of a single `VkDeviceMemory` block to be allocated as part of this pool, in bytes. Optional.
    
    Specify nonzero to set explicit, constant size of memory blocks used by this
    pool.
    
    Leave 0 to use default and let the library manage block sizes automatically.
    Sizes of particular blocks may vary.
    In this case, the pool will also support dedicated allocations.
    */
    blockSize:              VkDeviceSize;

    /** \brief Minimum number of blocks to be always allocated in this pool, even if they stay empty.
    
    Set to 0 to have no preallocated blocks and allow the pool be completely empty.
    */
    minBlockCount:          u64;

    /** \brief Maximum number of blocks that can be allocated in this pool. Optional.
    
    Set to 0 to use default, which is `SIZE_MAX`, which means no limit.
    
    Set to same value as VmaPoolCreateInfo::minBlockCount to have fixed amount of memory allocated
    throughout whole lifetime of this pool.
    */
    maxBlockCount:          u64;

    /** \brief A floating-point value between 0 and 1, indicating the priority of the allocations in this pool relative to other memory allocations.
    
    It is used only when #VMA_ALLOCATOR_CREATE_EXT_MEMORY_PRIORITY_BIT flag was used during creation of the #VmaAllocator object.
    Otherwise, this variable is ignored.
    */
    priority:               float;

    /** \brief Additional minimum alignment to be used for all allocations created from this pool. Can be 0.
    
    Leave 0 (default) not to impose any additional alignment. If not 0, it must be a power of two.
    It can be useful in cases where alignment returned by Vulkan by functions like `vkGetBufferMemoryRequirements` is not enough,
    e.g. when doing interop with OpenGL.
    */
    minAllocationAlignment: VkDeviceSize;

    /** \brief Additional `pNext` chain to be attached to `VkMemoryAllocateInfo` used for every allocation made by this pool. Optional.
    
    Optional, can be null. If not null, it must point to a `pNext` chain of structures that can be attached to `VkMemoryAllocateInfo`.
    It can be useful for special needs such as adding `VkExportMemoryAllocateInfoKHR`.
    Structures pointed by this member must remain alive and unchanged for the whole lifetime of the custom pool.
    
    Please note that some structures, e.g. `VkMemoryPriorityAllocateInfoEXT`, `VkMemoryDedicatedAllocateInfoKHR`,
    can be attached automatically by this library when using other, more convenient of its features.
    */
    pMemoryAllocateNext:    *void;
}

/**
Parameters of #VmaAllocation objects, that can be retrieved using function vmaGetAllocationInfo().

There is also an extended version of this structure that carries additional parameters: #VmaAllocationInfo2.
*/
VmaAllocationInfo :: struct {
    /** \brief Memory type index that this allocation was allocated from.
    
    It never changes.
    */
    memoryType:   u32;

    /** \brief Handle to Vulkan memory object.
    
    Same memory object can be shared by multiple allocations.
    
    It can change after the allocation is moved during \ref defragmentation.
    */
    deviceMemory: VkDeviceMemory;

    /** \brief Offset in `VkDeviceMemory` object to the beginning of this allocation, in bytes. `(deviceMemory, offset)` pair is unique to this allocation.
    
    You usually don't need to use this offset. If you create a buffer or an image together with the allocation using e.g. function
    vmaCreateBuffer(), vmaCreateImage(), functions that operate on these resources refer to the beginning of the buffer or image,
    not entire device memory block. Functions like vmaMapMemory(), vmaBindBufferMemory() also refer to the beginning of the allocation
    and apply this offset automatically.
    
    It can change after the allocation is moved during \ref defragmentation.
    */
    offset:       VkDeviceSize;

    /** \brief Size of this allocation, in bytes.
    
    It never changes.
    
    \note Allocation size returned in this variable may be greater than the size
    requested for the resource e.g. as `VkBufferCreateInfo::size`. Whole size of the
    allocation is accessible for operations on memory e.g. using a pointer after
    mapping with vmaMapMemory(), but operations on the resource e.g. using
    `vkCmdCopyBuffer` must be limited to the size of the resource.
    */
    size:         VkDeviceSize;

    /** \brief Pointer to the beginning of this allocation as mapped data.
    
    If the allocation hasn't been mapped using vmaMapMemory() and hasn't been
    created with #VMA_ALLOCATION_CREATE_MAPPED_BIT flag, this value is null.
    
    It can change after call to vmaMapMemory(), vmaUnmapMemory().
    It can also change after the allocation is moved during \ref defragmentation.
    */
    pMappedData:  *void;

    /** \brief Custom general-purpose pointer that was passed as VmaAllocationCreateInfo::pUserData or set using vmaSetAllocationUserData().
    
    It can change after call to vmaSetAllocationUserData() for this allocation.
    */
    pUserData:    *void;

    /** \brief Custom allocation name that was set with vmaSetAllocationName().
    
    It can change after call to vmaSetAllocationName() for this allocation.
    
    Another way to set custom name is to pass it in VmaAllocationCreateInfo::pUserData with
    additional flag #VMA_ALLOCATION_CREATE_USER_DATA_COPY_STRING_BIT set [DEPRECATED].
    */
    pName:        *u8;
}

/// Extended parameters of a #VmaAllocation object that can be retrieved using function vmaGetAllocationInfo2().
VmaAllocationInfo2 :: struct {
    /** \brief Basic parameters of the allocation.
    
    If you need only these, you can use function vmaGetAllocationInfo() and structure #VmaAllocationInfo instead.
    */
    allocationInfo:  VmaAllocationInfo;

    /** \brief Size of the `VkDeviceMemory` block that the allocation belongs to.
    
    In case of an allocation with dedicated memory, it will be equal to `allocationInfo.size`.
    */
    blockSize:       VkDeviceSize;

    /** \brief `VK_TRUE` if the allocation has dedicated memory, `VK_FALSE` if it was placed as part of a larger memory block.
    
    When `VK_TRUE`, it also means `VkMemoryDedicatedAllocateInfo` was used when creating the allocation
    (if VK_KHR_dedicated_allocation extension or Vulkan version >= 1.1 is enabled).
    */
    dedicatedMemory: VkBool32;
}

/** Callback function called during vmaBeginDefragmentation() to check custom criterion about ending current defragmentation pass.

Should return true if the defragmentation needs to stop current pass.
*/
PFN_vmaCheckDefragmentationBreakFunction :: #type (pUserData: *void) -> VkBool32 #c_call;

/** \brief Parameters for defragmentation.

To be used with function vmaBeginDefragmentation().
*/
VmaDefragmentationInfo :: struct {
    /// \brief Use combination of #VmaDefragmentationFlagBits.
    flags:                  VmaDefragmentationFlags;

    /** \brief Custom pool to be defragmented.
    
    If null then default pools will undergo defragmentation process.
    */
    pool:                   VmaPool;

    /** \brief Maximum numbers of bytes that can be copied during single pass, while moving allocations to different places.
    
    `0` means no limit.
    */
    maxBytesPerPass:        VkDeviceSize;

    /** \brief Maximum number of allocations that can be moved during single pass to a different place.
    
    `0` means no limit.
    */
    maxAllocationsPerPass:  u32;

    /** \brief Optional custom callback for stopping vmaBeginDefragmentation().
    
    Have to return true for breaking current defragmentation pass.
    */
    pfnBreakCallback:       PFN_vmaCheckDefragmentationBreakFunction;

    /// \brief Optional data to pass to custom callback for stopping pass of defragmentation.
    pBreakCallbackUserData: *void;
}

/// Single move of an allocation to be done for defragmentation.
VmaDefragmentationMove :: struct {
    /// Operation to be performed on the allocation by vmaEndDefragmentationPass(). Default value is #VMA_DEFRAGMENTATION_MOVE_OPERATION_COPY. You can modify it.
    operation:        VmaDefragmentationMoveOperation;

    /// Allocation that should be moved.
    srcAllocation:    VmaAllocation;

    /** \brief Temporary allocation pointing to destination memory that will replace `srcAllocation`.
    
    \warning Do not store this allocation in your data structures! It exists only temporarily, for the duration of the defragmentation pass,
    to be used for binding new buffer/image to the destination memory using e.g. vmaBindBufferMemory().
    vmaEndDefragmentationPass() will destroy it and make `srcAllocation` point to this memory.
    */
    dstTmpAllocation: VmaAllocation;
}

/** \brief Parameters for incremental defragmentation steps.

To be used with function vmaBeginDefragmentationPass().
*/
VmaDefragmentationPassMoveInfo :: struct {
    /// Number of elements in the `pMoves` array.
    moveCount: u32;

    /** \brief Array of moves to be performed by the user in the current defragmentation pass.
    
    Pointer to an array of `moveCount` elements, owned by VMA, created in vmaBeginDefragmentationPass(), destroyed in vmaEndDefragmentationPass().
    
    For each element, you should:
    
    1. Create a new buffer/image in the place pointed by VmaDefragmentationMove::dstMemory + VmaDefragmentationMove::dstOffset.
    2. Copy data from the VmaDefragmentationMove::srcAllocation e.g. using `vkCmdCopyBuffer`, `vkCmdCopyImage`.
    3. Make sure these commands finished executing on the GPU.
    4. Destroy the old buffer/image.
    
    Only then you can finish defragmentation pass by calling vmaEndDefragmentationPass().
    After this call, the allocation will point to the new place in memory.
    
    Alternatively, if you cannot move specific allocation, you can set VmaDefragmentationMove::operation to #VMA_DEFRAGMENTATION_MOVE_OPERATION_IGNORE.
    
    Alternatively, if you decide you want to completely remove the allocation:
    
    1. Destroy its buffer/image.
    2. Set VmaDefragmentationMove::operation to #VMA_DEFRAGMENTATION_MOVE_OPERATION_DESTROY.
    
    Then, after vmaEndDefragmentationPass() the allocation will be freed.
    */
    pMoves:    *VmaDefragmentationMove;
}

/// Statistics returned for defragmentation process in function vmaEndDefragmentation().
VmaDefragmentationStats :: struct {
    /// Total number of bytes that have been copied while moving allocations to different places.
    bytesMoved:              VkDeviceSize;

    /// Total number of bytes that have been released to the system by freeing empty `VkDeviceMemory` objects.
    bytesFreed:              VkDeviceSize;

    /// Number of allocations that have been moved to different places.
    allocationsMoved:        u32;

    /// Number of empty `VkDeviceMemory` objects that have been released to the system.
    deviceMemoryBlocksFreed: u32;
}

/// Parameters of created #VmaVirtualBlock object to be passed to vmaCreateVirtualBlock().
VmaVirtualBlockCreateInfo :: struct {
    /** \brief Total size of the virtual block.
    
    Sizes can be expressed in bytes or any units you want as long as you are consistent in using them.
    For example, if you allocate from some array of structures, 1 can mean single instance of entire structure.
    */
    size:                 VkDeviceSize;

    /** \brief Use combination of #VmaVirtualBlockCreateFlagBits.
    */
    flags:                VmaVirtualBlockCreateFlags;

    /** \brief Custom CPU memory allocation callbacks. Optional.
    
    Optional, can be null. When specified, they will be used for all CPU-side memory allocations.
    */
    pAllocationCallbacks: *VkAllocationCallbacks;
}

/// Parameters of created virtual allocation to be passed to vmaVirtualAllocate().
VmaVirtualAllocationCreateInfo :: struct {
    /** \brief Size of the allocation.
    
    Cannot be zero.
    */
    size:      VkDeviceSize;

    /** \brief Required alignment of the allocation. Optional.
    
    Must be power of two. Special value 0 has the same meaning as 1 - means no special alignment is required, so allocation can start at any offset.
    */
    alignment: VkDeviceSize;

    /** \brief Use combination of #VmaVirtualAllocationCreateFlagBits.
    */
    flags:     VmaVirtualAllocationCreateFlags;

    /** \brief Custom pointer to be associated with the allocation. Optional.
    
    It can be any value and can be used for user-defined purposes. It can be fetched or changed later.
    */
    pUserData: *void;
}

/// Parameters of an existing virtual allocation, returned by vmaGetVirtualAllocationInfo().
VmaVirtualAllocationInfo :: struct {
    /** \brief Offset of the allocation.
    
    Offset at which the allocation was made.
    */
    offset:    VkDeviceSize;

    /** \brief Size of the allocation.
    
    Same value as passed in VmaVirtualAllocationCreateInfo::size.
    */
    size:      VkDeviceSize;

    /** \brief Custom pointer associated with the allocation.
    
    Same value as passed in VmaVirtualAllocationCreateInfo::pUserData or to vmaSetVirtualAllocationUserData().
    */
    pUserData: *void;
}

/// Creates #VmaAllocator object.
vmaCreateAllocator :: (pCreateInfo: *VmaAllocatorCreateInfo, pAllocator: *VmaAllocator) -> VkResult #foreign libvma;

/// Destroys allocator object.
vmaDestroyAllocator :: (allocator: VmaAllocator) -> void #foreign libvma;

/** \brief Returns information about existing #VmaAllocator object - handle to Vulkan device etc.

It might be useful if you want to keep just the #VmaAllocator handle and fetch other required handles to
`VkPhysicalDevice`, `VkDevice` etc. every time using this function.
*/
vmaGetAllocatorInfo :: (allocator: VmaAllocator, pAllocatorInfo: *VmaAllocatorInfo) -> void #foreign libvma;

/**
PhysicalDeviceProperties are fetched from physicalDevice by the allocator.
You can access it here, without fetching it again on your own.
*/
vmaGetPhysicalDeviceProperties :: (allocator: VmaAllocator, ppPhysicalDeviceProperties: **VkPhysicalDeviceProperties) -> void #foreign libvma;

/**
PhysicalDeviceMemoryProperties are fetched from physicalDevice by the allocator.
You can access it here, without fetching it again on your own.
*/
vmaGetMemoryProperties :: (allocator: VmaAllocator, ppPhysicalDeviceMemoryProperties: **VkPhysicalDeviceMemoryProperties) -> void #foreign libvma;

/**
\brief Given Memory Type Index, returns Property Flags of this memory type.

This is just a convenience function. Same information can be obtained using
vmaGetMemoryProperties().
*/
vmaGetMemoryTypeProperties :: (allocator: VmaAllocator, memoryTypeIndex: u32, pFlags: *VkMemoryPropertyFlags) -> void #foreign libvma;

/** \brief Sets index of the current frame.
*/
vmaSetCurrentFrameIndex :: (allocator: VmaAllocator, frameIndex: u32) -> void #foreign libvma;

/** \brief Retrieves statistics from current state of the Allocator.

This function is called "calculate" not "get" because it has to traverse all
internal data structures, so it may be quite slow. Use it for debugging purposes.
For faster but more brief statistics suitable to be called every frame or every allocation,
use vmaGetHeapBudgets().

Note that when using allocator from multiple threads, returned information may immediately
become outdated.
*/
vmaCalculateStatistics :: (allocator: VmaAllocator, pStats: *VmaTotalStatistics) -> void #foreign libvma;

/** \brief Retrieves information about current memory usage and budget for all memory heaps.

\param allocator
\param[out] pBudgets Must point to array with number of elements at least equal to number of memory heaps in physical device used.

This function is called "get" not "calculate" because it is very fast, suitable to be called
every frame or every allocation. For more detailed statistics use vmaCalculateStatistics().

Note that when using allocator from multiple threads, returned information may immediately
become outdated.
*/
vmaGetHeapBudgets :: (allocator: VmaAllocator, pBudgets: *VmaBudget) -> void #foreign libvma;

/**
\brief Helps to find memoryTypeIndex, given memoryTypeBits and VmaAllocationCreateInfo.

This algorithm tries to find a memory type that:

- Is allowed by memoryTypeBits.
- Contains all the flags from pAllocationCreateInfo->requiredFlags.
- Matches intended usage.
- Has as many flags from pAllocationCreateInfo->preferredFlags as possible.

\return Returns VK_ERROR_FEATURE_NOT_PRESENT if not found. Receiving such result
from this function or any other allocating function probably means that your
device doesn't support any memory type with requested features for the specific
type of resource you want to use it for. Please check parameters of your
resource, like image layout (OPTIMAL versus LINEAR) or mip level count.
*/
vmaFindMemoryTypeIndex :: (allocator: VmaAllocator, memoryTypeBits: u32, pAllocationCreateInfo: *VmaAllocationCreateInfo, pMemoryTypeIndex: *u32) -> VkResult #foreign libvma;

/**
\brief Helps to find memoryTypeIndex, given VkBufferCreateInfo and VmaAllocationCreateInfo.

It can be useful e.g. to determine value to be used as VmaPoolCreateInfo::memoryTypeIndex.
It internally creates a temporary, dummy buffer that never has memory bound.
*/
vmaFindMemoryTypeIndexForBufferInfo :: (allocator: VmaAllocator, pBufferCreateInfo: *VkBufferCreateInfo, pAllocationCreateInfo: *VmaAllocationCreateInfo, pMemoryTypeIndex: *u32) -> VkResult #foreign libvma;

/**
\brief Helps to find memoryTypeIndex, given VkImageCreateInfo and VmaAllocationCreateInfo.

It can be useful e.g. to determine value to be used as VmaPoolCreateInfo::memoryTypeIndex.
It internally creates a temporary, dummy image that never has memory bound.
*/
vmaFindMemoryTypeIndexForImageInfo :: (allocator: VmaAllocator, pImageCreateInfo: *VkImageCreateInfo, pAllocationCreateInfo: *VmaAllocationCreateInfo, pMemoryTypeIndex: *u32) -> VkResult #foreign libvma;

/** \brief Allocates Vulkan device memory and creates #VmaPool object.

\param allocator Allocator object.
\param pCreateInfo Parameters of pool to create.
\param[out] pPool Handle to created pool.
*/
vmaCreatePool :: (allocator: VmaAllocator, pCreateInfo: *VmaPoolCreateInfo, pPool: *VmaPool) -> VkResult #foreign libvma;

/** \brief Destroys #VmaPool object and frees Vulkan device memory.
*/
vmaDestroyPool :: (allocator: VmaAllocator, pool: VmaPool) -> void #foreign libvma;

/** \brief Retrieves statistics of existing #VmaPool object.

\param allocator Allocator object.
\param pool Pool object.
\param[out] pPoolStats Statistics of specified pool.
*/
vmaGetPoolStatistics :: (allocator: VmaAllocator, pool: VmaPool, pPoolStats: *VmaStatistics) -> void #foreign libvma;

/** \brief Retrieves detailed statistics of existing #VmaPool object.

\param allocator Allocator object.
\param pool Pool object.
\param[out] pPoolStats Statistics of specified pool.
*/
vmaCalculatePoolStatistics :: (allocator: VmaAllocator, pool: VmaPool, pPoolStats: *VmaDetailedStatistics) -> void #foreign libvma;

/** \brief Checks magic number in margins around all allocations in given memory pool in search for corruptions.

Corruption detection is enabled only when `VMA_DEBUG_DETECT_CORRUPTION` macro is defined to nonzero,
`VMA_DEBUG_MARGIN` is defined to nonzero and the pool is created in memory type that is
`HOST_VISIBLE` and `HOST_COHERENT`. For more information, see [Corruption detection](@ref debugging_memory_usage_corruption_detection).

Possible return values:

- `VK_ERROR_FEATURE_NOT_PRESENT` - corruption detection is not enabled for specified pool.
- `VK_SUCCESS` - corruption detection has been performed and succeeded.
- `VK_ERROR_UNKNOWN` - corruption detection has been performed and found memory corruptions around one of the allocations.
`VMA_ASSERT` is also fired in that case.
- Other value: Error returned by Vulkan, e.g. memory mapping failure.
*/
vmaCheckPoolCorruption :: (allocator: VmaAllocator, pool: VmaPool) -> VkResult #foreign libvma;

/** \brief Retrieves name of a custom pool.

After the call `ppName` is either null or points to an internally-owned null-terminated string
containing name of the pool that was previously set. The pointer becomes invalid when the pool is
destroyed or its name is changed using vmaSetPoolName().
*/
vmaGetPoolName :: (allocator: VmaAllocator, pool: VmaPool, ppName: **u8) -> void #foreign libvma;

/** \brief Sets name of a custom pool.

`pName` can be either null or pointer to a null-terminated string with new name for the pool.
Function makes internal copy of the string, so it can be changed or freed immediately after this call.
*/
vmaSetPoolName :: (allocator: VmaAllocator, pool: VmaPool, pName: *u8) -> void #foreign libvma;

/** \brief General purpose memory allocation.

\param allocator
\param pVkMemoryRequirements
\param pCreateInfo
\param[out] pAllocation Handle to allocated memory.
\param[out] pAllocationInfo Optional. Information about allocated memory. It can be later fetched using function vmaGetAllocationInfo().

You should free the memory using vmaFreeMemory() or vmaFreeMemoryPages().

It is recommended to use vmaAllocateMemoryForBuffer(), vmaAllocateMemoryForImage(),
vmaCreateBuffer(), vmaCreateImage() instead whenever possible.
*/
vmaAllocateMemory :: (allocator: VmaAllocator, pVkMemoryRequirements: *VkMemoryRequirements, pCreateInfo: *VmaAllocationCreateInfo, pAllocation: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/** \brief General purpose memory allocation for multiple allocation objects at once.

\param allocator Allocator object.
\param pVkMemoryRequirements Memory requirements for each allocation.
\param pCreateInfo Creation parameters for each allocation.
\param allocationCount Number of allocations to make.
\param[out] pAllocations Pointer to array that will be filled with handles to created allocations.
\param[out] pAllocationInfo Optional. Pointer to array that will be filled with parameters of created allocations.

You should free the memory using vmaFreeMemory() or vmaFreeMemoryPages().

Word "pages" is just a suggestion to use this function to allocate pieces of memory needed for sparse binding.
It is just a general purpose allocation function able to make multiple allocations at once.
It may be internally optimized to be more efficient than calling vmaAllocateMemory() `allocationCount` times.

All allocations are made using same parameters. All of them are created out of the same memory pool and type.
If any allocation fails, all allocations already made within this function call are also freed, so that when
returned result is not `VK_SUCCESS`, `pAllocation` array is always entirely filled with `VK_NULL_HANDLE`.
*/
vmaAllocateMemoryPages :: (allocator: VmaAllocator, pVkMemoryRequirements: *VkMemoryRequirements, pCreateInfo: *VmaAllocationCreateInfo, allocationCount: u64, pAllocations: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/** \brief Allocates memory suitable for given `VkBuffer`.

\param allocator
\param buffer
\param pCreateInfo
\param[out] pAllocation Handle to allocated memory.
\param[out] pAllocationInfo Optional. Information about allocated memory. It can be later fetched using function vmaGetAllocationInfo().

It only creates #VmaAllocation. To bind the memory to the buffer, use vmaBindBufferMemory().

This is a special-purpose function. In most cases you should use vmaCreateBuffer().

You must free the allocation using vmaFreeMemory() when no longer needed.
*/
vmaAllocateMemoryForBuffer :: (allocator: VmaAllocator, buffer: VkBuffer, pCreateInfo: *VmaAllocationCreateInfo, pAllocation: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/** \brief Allocates memory suitable for given `VkImage`.

\param allocator
\param image
\param pCreateInfo
\param[out] pAllocation Handle to allocated memory.
\param[out] pAllocationInfo Optional. Information about allocated memory. It can be later fetched using function vmaGetAllocationInfo().

It only creates #VmaAllocation. To bind the memory to the buffer, use vmaBindImageMemory().

This is a special-purpose function. In most cases you should use vmaCreateImage().

You must free the allocation using vmaFreeMemory() when no longer needed.
*/
vmaAllocateMemoryForImage :: (allocator: VmaAllocator, image: VkImage, pCreateInfo: *VmaAllocationCreateInfo, pAllocation: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/** \brief Frees memory previously allocated using vmaAllocateMemory(), vmaAllocateMemoryForBuffer(), or vmaAllocateMemoryForImage().

Passing `VK_NULL_HANDLE` as `allocation` is valid. Such function call is just skipped.
*/
vmaFreeMemory :: (allocator: VmaAllocator, allocation: VmaAllocation) -> void #foreign libvma;

/** \brief Frees memory and destroys multiple allocations.

Word "pages" is just a suggestion to use this function to free pieces of memory used for sparse binding.
It is just a general purpose function to free memory and destroy allocations made using e.g. vmaAllocateMemory(),
vmaAllocateMemoryPages() and other functions.
It may be internally optimized to be more efficient than calling vmaFreeMemory() `allocationCount` times.

Allocations in `pAllocations` array can come from any memory pools and types.
Passing `VK_NULL_HANDLE` as elements of `pAllocations` array is valid. Such entries are just skipped.
*/
vmaFreeMemoryPages :: (allocator: VmaAllocator, allocationCount: u64, pAllocations: *VmaAllocation) -> void #foreign libvma;

/** \brief Returns current information about specified allocation.

Current parameters of given allocation are returned in `pAllocationInfo`.

Although this function doesn't lock any mutex, so it should be quite efficient,
you should avoid calling it too often.
You can retrieve same VmaAllocationInfo structure while creating your resource, from function
vmaCreateBuffer(), vmaCreateImage(). You can remember it if you are sure parameters don't change
(e.g. due to defragmentation).

There is also a new function vmaGetAllocationInfo2() that offers extended information
about the allocation, returned using new structure #VmaAllocationInfo2.
*/
vmaGetAllocationInfo :: (allocator: VmaAllocator, allocation: VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> void #foreign libvma;

/** \brief Returns extended information about specified allocation.

Current parameters of given allocation are returned in `pAllocationInfo`.
Extended parameters in structure #VmaAllocationInfo2 include memory block size
and a flag telling whether the allocation has dedicated memory.
It can be useful e.g. for interop with OpenGL.
*/
vmaGetAllocationInfo2 :: (allocator: VmaAllocator, allocation: VmaAllocation, pAllocationInfo: *VmaAllocationInfo2) -> void #foreign libvma;

/** \brief Sets pUserData in given allocation to new value.

The value of pointer `pUserData` is copied to allocation's `pUserData`.
It is opaque, so you can use it however you want - e.g.
as a pointer, ordinal number or some handle to you own data.
*/
vmaSetAllocationUserData :: (allocator: VmaAllocator, allocation: VmaAllocation, pUserData: *void) -> void #foreign libvma;

/** \brief Sets pName in given allocation to new value.

`pName` must be either null, or pointer to a null-terminated string. The function
makes local copy of the string and sets it as allocation's `pName`. String
passed as pName doesn't need to be valid for whole lifetime of the allocation -
you can free it after this call. String previously pointed by allocation's
`pName` is freed from memory.
*/
vmaSetAllocationName :: (allocator: VmaAllocator, allocation: VmaAllocation, pName: *u8) -> void #foreign libvma;

/**
\brief Given an allocation, returns Property Flags of its memory type.

This is just a convenience function. Same information can be obtained using
vmaGetAllocationInfo() + vmaGetMemoryProperties().
*/
vmaGetAllocationMemoryProperties :: (allocator: VmaAllocator, allocation: VmaAllocation, pFlags: *VkMemoryPropertyFlags) -> void #foreign libvma;

/** \brief Maps memory represented by given allocation and returns pointer to it.

Maps memory represented by given allocation to make it accessible to CPU code.
When succeeded, `*ppData` contains pointer to first byte of this memory.

\warning
If the allocation is part of a bigger `VkDeviceMemory` block, returned pointer is
correctly offsetted to the beginning of region assigned to this particular allocation.
Unlike the result of `vkMapMemory`, it points to the allocation, not to the beginning of the whole block.
You should not add VmaAllocationInfo::offset to it!

Mapping is internally reference-counted and synchronized, so despite raw Vulkan
function `vkMapMemory()` cannot be used to map same block of `VkDeviceMemory`
multiple times simultaneously, it is safe to call this function on allocations
assigned to the same memory block. Actual Vulkan memory will be mapped on first
mapping and unmapped on last unmapping.

If the function succeeded, you must call vmaUnmapMemory() to unmap the
allocation when mapping is no longer needed or before freeing the allocation, at
the latest.

It also safe to call this function multiple times on the same allocation. You
must call vmaUnmapMemory() same number of times as you called vmaMapMemory().

It is also safe to call this function on allocation created with
#VMA_ALLOCATION_CREATE_MAPPED_BIT flag. Its memory stays mapped all the time.
You must still call vmaUnmapMemory() same number of times as you called
vmaMapMemory(). You must not call vmaUnmapMemory() additional time to free the
"0-th" mapping made automatically due to #VMA_ALLOCATION_CREATE_MAPPED_BIT flag.

This function fails when used on allocation made in memory type that is not
`HOST_VISIBLE`.

This function doesn't automatically flush or invalidate caches.
If the allocation is made from a memory types that is not `HOST_COHERENT`,
you also need to use vmaInvalidateAllocation() / vmaFlushAllocation(), as required by Vulkan specification.
*/
vmaMapMemory :: (allocator: VmaAllocator, allocation: VmaAllocation, ppData: **void) -> VkResult #foreign libvma;

/** \brief Unmaps memory represented by given allocation, mapped previously using vmaMapMemory().

For details, see description of vmaMapMemory().

This function doesn't automatically flush or invalidate caches.
If the allocation is made from a memory types that is not `HOST_COHERENT`,
you also need to use vmaInvalidateAllocation() / vmaFlushAllocation(), as required by Vulkan specification.
*/
vmaUnmapMemory :: (allocator: VmaAllocator, allocation: VmaAllocation) -> void #foreign libvma;

/** \brief Flushes memory of given allocation.

Calls `vkFlushMappedMemoryRanges()` for memory associated with given range of given allocation.
It needs to be called after writing to a mapped memory for memory types that are not `HOST_COHERENT`.
Unmap operation doesn't do that automatically.

- `offset` must be relative to the beginning of allocation.
- `size` can be `VK_WHOLE_SIZE`. It means all memory from `offset` the the end of given allocation.
- `offset` and `size` don't have to be aligned.
They are internally rounded down/up to multiply of `nonCoherentAtomSize`.
- If `size` is 0, this call is ignored.
- If memory type that the `allocation` belongs to is not `HOST_VISIBLE` or it is `HOST_COHERENT`,
this call is ignored.

Warning! `offset` and `size` are relative to the contents of given `allocation`.
If you mean whole allocation, you can pass 0 and `VK_WHOLE_SIZE`, respectively.
Do not pass allocation's offset as `offset`!!!

This function returns the `VkResult` from `vkFlushMappedMemoryRanges` if it is
called, otherwise `VK_SUCCESS`.
*/
vmaFlushAllocation :: (allocator: VmaAllocator, allocation: VmaAllocation, offset: VkDeviceSize, size: VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Invalidates memory of given allocation.

Calls `vkInvalidateMappedMemoryRanges()` for memory associated with given range of given allocation.
It needs to be called before reading from a mapped memory for memory types that are not `HOST_COHERENT`.
Map operation doesn't do that automatically.

- `offset` must be relative to the beginning of allocation.
- `size` can be `VK_WHOLE_SIZE`. It means all memory from `offset` the the end of given allocation.
- `offset` and `size` don't have to be aligned.
They are internally rounded down/up to multiply of `nonCoherentAtomSize`.
- If `size` is 0, this call is ignored.
- If memory type that the `allocation` belongs to is not `HOST_VISIBLE` or it is `HOST_COHERENT`,
this call is ignored.

Warning! `offset` and `size` are relative to the contents of given `allocation`.
If you mean whole allocation, you can pass 0 and `VK_WHOLE_SIZE`, respectively.
Do not pass allocation's offset as `offset`!!!

This function returns the `VkResult` from `vkInvalidateMappedMemoryRanges` if
it is called, otherwise `VK_SUCCESS`.
*/
vmaInvalidateAllocation :: (allocator: VmaAllocator, allocation: VmaAllocation, offset: VkDeviceSize, size: VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Flushes memory of given set of allocations.

Calls `vkFlushMappedMemoryRanges()` for memory associated with given ranges of given allocations.
For more information, see documentation of vmaFlushAllocation().

\param allocator
\param allocationCount
\param allocations
\param offsets If not null, it must point to an array of offsets of regions to flush, relative to the beginning of respective allocations. Null means all offsets are zero.
\param sizes If not null, it must point to an array of sizes of regions to flush in respective allocations. Null means `VK_WHOLE_SIZE` for all allocations.

This function returns the `VkResult` from `vkFlushMappedMemoryRanges` if it is
called, otherwise `VK_SUCCESS`.
*/
vmaFlushAllocations :: (allocator: VmaAllocator, allocationCount: u32, allocations: *VmaAllocation, offsets: *VkDeviceSize, sizes: *VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Invalidates memory of given set of allocations.

Calls `vkInvalidateMappedMemoryRanges()` for memory associated with given ranges of given allocations.
For more information, see documentation of vmaInvalidateAllocation().

\param allocator
\param allocationCount
\param allocations
\param offsets If not null, it must point to an array of offsets of regions to flush, relative to the beginning of respective allocations. Null means all offsets are zero.
\param sizes If not null, it must point to an array of sizes of regions to flush in respective allocations. Null means `VK_WHOLE_SIZE` for all allocations.

This function returns the `VkResult` from `vkInvalidateMappedMemoryRanges` if it is
called, otherwise `VK_SUCCESS`.
*/
vmaInvalidateAllocations :: (allocator: VmaAllocator, allocationCount: u32, allocations: *VmaAllocation, offsets: *VkDeviceSize, sizes: *VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Maps the allocation temporarily if needed, copies data from specified host pointer to it, and flushes the memory from the host caches if needed.

\param allocator
\param pSrcHostPointer Pointer to the host data that become source of the copy.
\param dstAllocation   Handle to the allocation that becomes destination of the copy.
\param dstAllocationLocalOffset  Offset within `dstAllocation` where to write copied data, in bytes.
\param size            Number of bytes to copy.

This is a convenience function that allows to copy data from a host pointer to an allocation easily.
Same behavior can be achieved by calling vmaMapMemory(), `memcpy()`, vmaUnmapMemory(), vmaFlushAllocation().

This function can be called only for allocations created in a memory type that has `VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT` flag.
It can be ensured e.g. by using #VMA_MEMORY_USAGE_AUTO and #VMA_ALLOCATION_CREATE_HOST_ACCESS_SEQUENTIAL_WRITE_BIT or
#VMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT.
Otherwise, the function will fail and generate a Validation Layers error.

`dstAllocationLocalOffset` is relative to the contents of given `dstAllocation`.
If you mean whole allocation, you should pass 0.
Do not pass allocation's offset within device memory block this parameter!
*/
vmaCopyMemoryToAllocation :: (allocator: VmaAllocator, pSrcHostPointer: *void, dstAllocation: VmaAllocation, dstAllocationLocalOffset: VkDeviceSize, size: VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Invalidates memory in the host caches if needed, maps the allocation temporarily if needed, and copies data from it to a specified host pointer.

\param allocator
\param srcAllocation   Handle to the allocation that becomes source of the copy.
\param srcAllocationLocalOffset  Offset within `srcAllocation` where to read copied data, in bytes.
\param pDstHostPointer Pointer to the host memory that become destination of the copy.
\param size            Number of bytes to copy.

This is a convenience function that allows to copy data from an allocation to a host pointer easily.
Same behavior can be achieved by calling vmaInvalidateAllocation(), vmaMapMemory(), `memcpy()`, vmaUnmapMemory().

This function should be called only for allocations created in a memory type that has `VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT`
and `VK_MEMORY_PROPERTY_HOST_CACHED_BIT` flag.
It can be ensured e.g. by using #VMA_MEMORY_USAGE_AUTO and #VMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT.
Otherwise, the function may fail and generate a Validation Layers error.
It may also work very slowly when reading from an uncached memory.

`srcAllocationLocalOffset` is relative to the contents of given `srcAllocation`.
If you mean whole allocation, you should pass 0.
Do not pass allocation's offset within device memory block as this parameter!
*/
vmaCopyAllocationToMemory :: (allocator: VmaAllocator, srcAllocation: VmaAllocation, srcAllocationLocalOffset: VkDeviceSize, pDstHostPointer: *void, size: VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Checks magic number in margins around all allocations in given memory types (in both default and custom pools) in search for corruptions.

\param allocator
\param memoryTypeBits Bit mask, where each bit set means that a memory type with that index should be checked.

Corruption detection is enabled only when `VMA_DEBUG_DETECT_CORRUPTION` macro is defined to nonzero,
`VMA_DEBUG_MARGIN` is defined to nonzero and only for memory types that are
`HOST_VISIBLE` and `HOST_COHERENT`. For more information, see [Corruption detection](@ref debugging_memory_usage_corruption_detection).

Possible return values:

- `VK_ERROR_FEATURE_NOT_PRESENT` - corruption detection is not enabled for any of specified memory types.
- `VK_SUCCESS` - corruption detection has been performed and succeeded.
- `VK_ERROR_UNKNOWN` - corruption detection has been performed and found memory corruptions around one of the allocations.
`VMA_ASSERT` is also fired in that case.
- Other value: Error returned by Vulkan, e.g. memory mapping failure.
*/
vmaCheckCorruption :: (allocator: VmaAllocator, memoryTypeBits: u32) -> VkResult #foreign libvma;

/** \brief Begins defragmentation process.

\param allocator Allocator object.
\param pInfo Structure filled with parameters of defragmentation.
\param[out] pContext Context object that must be passed to vmaEndDefragmentation() to finish defragmentation.
\returns
- `VK_SUCCESS` if defragmentation can begin.
- `VK_ERROR_FEATURE_NOT_PRESENT` if defragmentation is not supported.

For more information about defragmentation, see documentation chapter:
[Defragmentation](@ref defragmentation).
*/
vmaBeginDefragmentation :: (allocator: VmaAllocator, pInfo: *VmaDefragmentationInfo, pContext: *VmaDefragmentationContext) -> VkResult #foreign libvma;

/** \brief Ends defragmentation process.

\param allocator Allocator object.
\param context Context object that has been created by vmaBeginDefragmentation().
\param[out] pStats Optional stats for the defragmentation. Can be null.

Use this function to finish defragmentation started by vmaBeginDefragmentation().
*/
vmaEndDefragmentation :: (allocator: VmaAllocator, _context: VmaDefragmentationContext, pStats: *VmaDefragmentationStats) -> void #foreign libvma;

/** \brief Starts single defragmentation pass.

\param allocator Allocator object.
\param context Context object that has been created by vmaBeginDefragmentation().
\param[out] pPassInfo Computed information for current pass.
\returns
- `VK_SUCCESS` if no more moves are possible. Then you can omit call to vmaEndDefragmentationPass() and simply end whole defragmentation.
- `VK_INCOMPLETE` if there are pending moves returned in `pPassInfo`. You need to perform them, call vmaEndDefragmentationPass(),
and then preferably try another pass with vmaBeginDefragmentationPass().
*/
vmaBeginDefragmentationPass :: (allocator: VmaAllocator, _context: VmaDefragmentationContext, pPassInfo: *VmaDefragmentationPassMoveInfo) -> VkResult #foreign libvma;

/** \brief Ends single defragmentation pass.

\param allocator Allocator object.
\param context Context object that has been created by vmaBeginDefragmentation().
\param pPassInfo Computed information for current pass filled by vmaBeginDefragmentationPass() and possibly modified by you.

Returns `VK_SUCCESS` if no more moves are possible or `VK_INCOMPLETE` if more defragmentations are possible.

Ends incremental defragmentation pass and commits all defragmentation moves from `pPassInfo`.
After this call:

- Allocations at `pPassInfo[i].srcAllocation` that had `pPassInfo[i].operation ==` #VMA_DEFRAGMENTATION_MOVE_OPERATION_COPY
(which is the default) will be pointing to the new destination place.
- Allocation at `pPassInfo[i].srcAllocation` that had `pPassInfo[i].operation ==` #VMA_DEFRAGMENTATION_MOVE_OPERATION_DESTROY
will be freed.

If no more moves are possible you can end whole defragmentation.
*/
vmaEndDefragmentationPass :: (allocator: VmaAllocator, _context: VmaDefragmentationContext, pPassInfo: *VmaDefragmentationPassMoveInfo) -> VkResult #foreign libvma;

/** \brief Binds buffer to allocation.

Binds specified buffer to region of memory represented by specified allocation.
Gets `VkDeviceMemory` handle and offset from the allocation.
If you want to create a buffer, allocate memory for it and bind them together separately,
you should use this function for binding instead of standard `vkBindBufferMemory()`,
because it ensures proper synchronization so that when a `VkDeviceMemory` object is used by multiple
allocations, calls to `vkBind*Memory()` or `vkMapMemory()` won't happen from multiple threads simultaneously
(which is illegal in Vulkan).

It is recommended to use function vmaCreateBuffer() instead of this one.
*/
vmaBindBufferMemory :: (allocator: VmaAllocator, allocation: VmaAllocation, buffer: VkBuffer) -> VkResult #foreign libvma;

/** \brief Binds buffer to allocation with additional parameters.

\param allocator
\param allocation
\param allocationLocalOffset Additional offset to be added while binding, relative to the beginning of the `allocation`. Normally it should be 0.
\param buffer
\param pNext A chain of structures to be attached to `VkBindBufferMemoryInfoKHR` structure used internally. Normally it should be null.

This function is similar to vmaBindBufferMemory(), but it provides additional parameters.

If `pNext` is not null, #VmaAllocator object must have been created with #VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT flag
or with VmaAllocatorCreateInfo::vulkanApiVersion `>= VK_API_VERSION_1_1`. Otherwise the call fails.
*/
vmaBindBufferMemory2 :: (allocator: VmaAllocator, allocation: VmaAllocation, allocationLocalOffset: VkDeviceSize, buffer: VkBuffer, pNext: *void) -> VkResult #foreign libvma;

/** \brief Binds image to allocation.

Binds specified image to region of memory represented by specified allocation.
Gets `VkDeviceMemory` handle and offset from the allocation.
If you want to create an image, allocate memory for it and bind them together separately,
you should use this function for binding instead of standard `vkBindImageMemory()`,
because it ensures proper synchronization so that when a `VkDeviceMemory` object is used by multiple
allocations, calls to `vkBind*Memory()` or `vkMapMemory()` won't happen from multiple threads simultaneously
(which is illegal in Vulkan).

It is recommended to use function vmaCreateImage() instead of this one.
*/
vmaBindImageMemory :: (allocator: VmaAllocator, allocation: VmaAllocation, image: VkImage) -> VkResult #foreign libvma;

/** \brief Binds image to allocation with additional parameters.

\param allocator
\param allocation
\param allocationLocalOffset Additional offset to be added while binding, relative to the beginning of the `allocation`. Normally it should be 0.
\param image
\param pNext A chain of structures to be attached to `VkBindImageMemoryInfoKHR` structure used internally. Normally it should be null.

This function is similar to vmaBindImageMemory(), but it provides additional parameters.

If `pNext` is not null, #VmaAllocator object must have been created with #VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT flag
or with VmaAllocatorCreateInfo::vulkanApiVersion `>= VK_API_VERSION_1_1`. Otherwise the call fails.
*/
vmaBindImageMemory2 :: (allocator: VmaAllocator, allocation: VmaAllocation, allocationLocalOffset: VkDeviceSize, image: VkImage, pNext: *void) -> VkResult #foreign libvma;

/** \brief Creates a new `VkBuffer`, allocates and binds memory for it.

\param allocator
\param pBufferCreateInfo
\param pAllocationCreateInfo
\param[out] pBuffer Buffer that was created.
\param[out] pAllocation Allocation that was created.
\param[out] pAllocationInfo Optional. Information about allocated memory. It can be later fetched using function vmaGetAllocationInfo().

This function automatically:

-# Creates buffer.
-# Allocates appropriate memory for it.
-# Binds the buffer with the memory.

If any of these operations fail, buffer and allocation are not created,
returned value is negative error code, `*pBuffer` and `*pAllocation` are null.

If the function succeeded, you must destroy both buffer and allocation when you
no longer need them using either convenience function vmaDestroyBuffer() or
separately, using `vkDestroyBuffer()` and vmaFreeMemory().

If #VMA_ALLOCATOR_CREATE_KHR_DEDICATED_ALLOCATION_BIT flag was used,
VK_KHR_dedicated_allocation extension is used internally to query driver whether
it requires or prefers the new buffer to have dedicated allocation. If yes,
and if dedicated allocation is possible
(#VMA_ALLOCATION_CREATE_NEVER_ALLOCATE_BIT is not used), it creates dedicated
allocation for this buffer, just like when using
#VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT.

\note This function creates a new `VkBuffer`. Sub-allocation of parts of one large buffer,
although recommended as a good practice, is out of scope of this library and could be implemented
by the user as a higher-level logic on top of VMA.
*/
vmaCreateBuffer :: (allocator: VmaAllocator, pBufferCreateInfo: *VkBufferCreateInfo, pAllocationCreateInfo: *VmaAllocationCreateInfo, pBuffer: *VkBuffer, pAllocation: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/** \brief Creates a buffer with additional minimum alignment.

Similar to vmaCreateBuffer() but provides additional parameter `minAlignment` which allows to specify custom,
minimum alignment to be used when placing the buffer inside a larger memory block, which may be needed e.g.
for interop with OpenGL.
*/
vmaCreateBufferWithAlignment :: (allocator: VmaAllocator, pBufferCreateInfo: *VkBufferCreateInfo, pAllocationCreateInfo: *VmaAllocationCreateInfo, minAlignment: VkDeviceSize, pBuffer: *VkBuffer, pAllocation: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/** \brief Creates a new `VkBuffer`, binds already created memory for it.

\param allocator
\param allocation Allocation that provides memory to be used for binding new buffer to it.
\param pBufferCreateInfo
\param[out] pBuffer Buffer that was created.

This function automatically:

-# Creates buffer.
-# Binds the buffer with the supplied memory.

If any of these operations fail, buffer is not created,
returned value is negative error code and `*pBuffer` is null.

If the function succeeded, you must destroy the buffer when you
no longer need it using `vkDestroyBuffer()`. If you want to also destroy the corresponding
allocation you can use convenience function vmaDestroyBuffer().

\note There is a new version of this function augmented with parameter `allocationLocalOffset` - see vmaCreateAliasingBuffer2().
*/
vmaCreateAliasingBuffer :: (allocator: VmaAllocator, allocation: VmaAllocation, pBufferCreateInfo: *VkBufferCreateInfo, pBuffer: *VkBuffer) -> VkResult #foreign libvma;

/** \brief Creates a new `VkBuffer`, binds already created memory for it.

\param allocator
\param allocation Allocation that provides memory to be used for binding new buffer to it.
\param allocationLocalOffset Additional offset to be added while binding, relative to the beginning of the allocation. Normally it should be 0.
\param pBufferCreateInfo
\param[out] pBuffer Buffer that was created.

This function automatically:

-# Creates buffer.
-# Binds the buffer with the supplied memory.

If any of these operations fail, buffer is not created,
returned value is negative error code and `*pBuffer` is null.

If the function succeeded, you must destroy the buffer when you
no longer need it using `vkDestroyBuffer()`. If you want to also destroy the corresponding
allocation you can use convenience function vmaDestroyBuffer().

\note This is a new version of the function augmented with parameter `allocationLocalOffset`.
*/
vmaCreateAliasingBuffer2 :: (allocator: VmaAllocator, allocation: VmaAllocation, allocationLocalOffset: VkDeviceSize, pBufferCreateInfo: *VkBufferCreateInfo, pBuffer: *VkBuffer) -> VkResult #foreign libvma;

/** \brief Destroys Vulkan buffer and frees allocated memory.

This is just a convenience function equivalent to:

\code
vkDestroyBuffer(device, buffer, allocationCallbacks);
vmaFreeMemory(allocator, allocation);
\endcode

It is safe to pass null as buffer and/or allocation.
*/
vmaDestroyBuffer :: (allocator: VmaAllocator, buffer: VkBuffer, allocation: VmaAllocation) -> void #foreign libvma;

/// Function similar to vmaCreateBuffer().
vmaCreateImage :: (allocator: VmaAllocator, pImageCreateInfo: *VkImageCreateInfo, pAllocationCreateInfo: *VmaAllocationCreateInfo, pImage: *VkImage, pAllocation: *VmaAllocation, pAllocationInfo: *VmaAllocationInfo) -> VkResult #foreign libvma;

/// Function similar to vmaCreateAliasingBuffer() but for images.
vmaCreateAliasingImage :: (allocator: VmaAllocator, allocation: VmaAllocation, pImageCreateInfo: *VkImageCreateInfo, pImage: *VkImage) -> VkResult #foreign libvma;

/// Function similar to vmaCreateAliasingBuffer2() but for images.
vmaCreateAliasingImage2 :: (allocator: VmaAllocator, allocation: VmaAllocation, allocationLocalOffset: VkDeviceSize, pImageCreateInfo: *VkImageCreateInfo, pImage: *VkImage) -> VkResult #foreign libvma;

/** \brief Destroys Vulkan image and frees allocated memory.

This is just a convenience function equivalent to:

\code
vkDestroyImage(device, image, allocationCallbacks);
vmaFreeMemory(allocator, allocation);
\endcode

It is safe to pass null as image and/or allocation.
*/
vmaDestroyImage :: (allocator: VmaAllocator, image: VkImage, allocation: VmaAllocation) -> void #foreign libvma;

/** \brief Creates new #VmaVirtualBlock object.

\param pCreateInfo Parameters for creation.
\param[out] pVirtualBlock Returned virtual block object or `VMA_NULL` if creation failed.
*/
vmaCreateVirtualBlock :: (pCreateInfo: *VmaVirtualBlockCreateInfo, pVirtualBlock: *VmaVirtualBlock) -> VkResult #foreign libvma;

/** \brief Destroys #VmaVirtualBlock object.

Please note that you should consciously handle virtual allocations that could remain unfreed in the block.
You should either free them individually using vmaVirtualFree() or call vmaClearVirtualBlock()
if you are sure this is what you want. If you do neither, an assert is called.

If you keep pointers to some additional metadata associated with your virtual allocations in their `pUserData`,
don't forget to free them.
*/
vmaDestroyVirtualBlock :: (virtualBlock: VmaVirtualBlock) -> void #foreign libvma;

/** \brief Returns true of the #VmaVirtualBlock is empty - contains 0 virtual allocations and has all its space available for new allocations.
*/
vmaIsVirtualBlockEmpty :: (virtualBlock: VmaVirtualBlock) -> VkBool32 #foreign libvma;

/** \brief Returns information about a specific virtual allocation within a virtual block, like its size and `pUserData` pointer.
*/
vmaGetVirtualAllocationInfo :: (virtualBlock: VmaVirtualBlock, allocation: VmaVirtualAllocation, pVirtualAllocInfo: *VmaVirtualAllocationInfo) -> void #foreign libvma;

/** \brief Allocates new virtual allocation inside given #VmaVirtualBlock.

If the allocation fails due to not enough free space available, `VK_ERROR_OUT_OF_DEVICE_MEMORY` is returned
(despite the function doesn't ever allocate actual GPU memory).
`pAllocation` is then set to `VK_NULL_HANDLE` and `pOffset`, if not null, it set to `UINT64_MAX`.

\param virtualBlock Virtual block
\param pCreateInfo Parameters for the allocation
\param[out] pAllocation Returned handle of the new allocation
\param[out] pOffset Returned offset of the new allocation. Optional, can be null.
*/
vmaVirtualAllocate :: (virtualBlock: VmaVirtualBlock, pCreateInfo: *VmaVirtualAllocationCreateInfo, pAllocation: *VmaVirtualAllocation, pOffset: *VkDeviceSize) -> VkResult #foreign libvma;

/** \brief Frees virtual allocation inside given #VmaVirtualBlock.

It is correct to call this function with `allocation == VK_NULL_HANDLE` - it does nothing.
*/
vmaVirtualFree :: (virtualBlock: VmaVirtualBlock, allocation: VmaVirtualAllocation) -> void #foreign libvma;

/** \brief Frees all virtual allocations inside given #VmaVirtualBlock.

You must either call this function or free each virtual allocation individually with vmaVirtualFree()
before destroying a virtual block. Otherwise, an assert is called.

If you keep pointer to some additional metadata associated with your virtual allocation in its `pUserData`,
don't forget to free it as well.
*/
vmaClearVirtualBlock :: (virtualBlock: VmaVirtualBlock) -> void #foreign libvma;

/** \brief Changes custom pointer associated with given virtual allocation.
*/
vmaSetVirtualAllocationUserData :: (virtualBlock: VmaVirtualBlock, allocation: VmaVirtualAllocation, pUserData: *void) -> void #foreign libvma;

/** \brief Calculates and returns statistics about virtual allocations and memory usage in given #VmaVirtualBlock.

This function is fast to call. For more detailed statistics, see vmaCalculateVirtualBlockStatistics().
*/
vmaGetVirtualBlockStatistics :: (virtualBlock: VmaVirtualBlock, pStats: *VmaStatistics) -> void #foreign libvma;

/** \brief Calculates and returns detailed statistics about virtual allocations and memory usage in given #VmaVirtualBlock.

This function is slow to call. Use for debugging purposes.
For less detailed statistics, see vmaGetVirtualBlockStatistics().
*/
vmaCalculateVirtualBlockStatistics :: (virtualBlock: VmaVirtualBlock, pStats: *VmaDetailedStatistics) -> void #foreign libvma;

/** \brief Builds and returns a null-terminated string in JSON format with information about given #VmaVirtualBlock.
\param virtualBlock Virtual block.
\param[out] ppStatsString Returned string.
\param detailedMap Pass `VK_FALSE` to only obtain statistics as returned by vmaCalculateVirtualBlockStatistics(). Pass `VK_TRUE` to also obtain full list of allocations and free spaces.

Returned string must be freed using vmaFreeVirtualBlockStatsString().
*/
vmaBuildVirtualBlockStatsString :: (virtualBlock: VmaVirtualBlock, ppStatsString: **u8, detailedMap: VkBool32) -> void #foreign libvma;

/// Frees a string returned by vmaBuildVirtualBlockStatsString().
vmaFreeVirtualBlockStatsString :: (virtualBlock: VmaVirtualBlock, pStatsString: *u8) -> void #foreign libvma;

/** \brief Builds and returns statistics as a null-terminated string in JSON format.
\param allocator
\param[out] ppStatsString Must be freed using vmaFreeStatsString() function.
\param detailedMap
*/
vmaBuildStatsString :: (allocator: VmaAllocator, ppStatsString: **u8, detailedMap: VkBool32) -> void #foreign libvma;

vmaFreeStatsString :: (allocator: VmaAllocator, pStatsString: *u8) -> void #foreign libvma;

#scope_file

#import "jai-vulkan";

#if OS == .WINDOWS {
	libvma :: #library "windows/VMA";
} else #if OS == .LINUX {
	libvma :: #library "linux/VMA";
} else {
	#assert(false);
}
