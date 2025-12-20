// This started life as an example written by the compiler team, that used GLFW.
// It was then simplified by Hamad Almamari so that it didn't require GLFW.
// Modifications licensed under the MIT License.

// I did a little bit more cosmetic burnishing, but we haven't looked at this code
// seriously, so, we make no representation that
// this is good code or shows the idiomatic way to do things.

// This example currently only compiles on Windows.

// Good reference:
// https://renderdoc.org/vulkan-in-30-minutes.html

// Good examples:
// https://sopyer.github.io/b/post/minimal-vulkan-sample/
// https://sopyer.github.io/b/post/static-dynamic-geometry-vulkan/

// GLVW Vulkan guide:
// https://www.glfw.org/docs/latest/vulkan_guide.html

// Not so great tutorial:
// https://vulkan-tutorial.com/Drawing_a_triangle/Setup/Base_code

// Using RTX from Vulkan:
// https://iorange.github.io/

#import "Basic";
#import "String";
// #import "Vulkan";
#import,file "../module.jai";
#import "Math";

#import "Window_Creation";
#import "Input";
#if OS ==.WINDOWS {
    #import "Windows";
}

DEBUG :: true;

width                 : u32 = 640;
height                : u32 = 480;
window                : Window_Type;

instance              : VkInstance;
debug_callback_handle : VkDebugReportCallbackEXT;

surface               : VkSurfaceKHR;

physical_device       : VkPhysicalDevice;
queue_family_index    : u32;
device                : VkDevice;
queue                 : VkQueue;

main :: () {
    // Create window
    window = create_window(xx width, xx height, "Hello Vulkan");
  
    // Vulkan staff
    print_available_vulkan_extensions();

    // Init Vulkan.
    if !init_vulkan() {
        print("Vulkan initialization failed.\n");
        return;
    }
    defer deinit_vulkan();

     // Init Surface.
    if !init_surface() {
        print("Window surface creation failed.\n");
        return;
    }
    defer deinit_surface();


    // Init Device.
    if !init_device() {
        print("Device initialization failed.\n");
        return;
    }
    defer deinit_device();


    // Init Swapchain.
    if !init_swapchain() {
        print("Swapchain initialization failed.\n");
        return;
    }
    defer deinit_swapchain();


    // Init Render.
    init_render();
    defer deinit_render();

    quit := false;
    while !quit {
        update_window_events();

        for events_this_frame {
            if it.type == .QUIT then quit = true;
        }

        draw_frame();
    }

}


error_callback :: (error: s32, description: *u8) #c_call {
    new_context: Context;

    TEMPORARY_STORAGE_SIZE :: 1000;
    storage_buf: [TEMPORARY_STORAGE_SIZE] u8;

    storage: Temporary_Storage;
    storage.data = storage_buf.data;
    storage.size = TEMPORARY_STORAGE_SIZE;
    new_context.temporary_storage = *storage;

    //new_context.logger = debug_log_params.main_context.logger;

    push_context new_context {
        print("Error: %\n", to_string(description));
    }
}


debug_callback :: (flags: VkDebugReportFlagsEXT, objType: VkDebugReportObjectTypeEXT, obj: u64, location: u64, code: s32, layerPrefix: *u8, msg: *u8, userData: *void) -> VkBool32 #c_call {
    new_context: Context;
    push_context new_context {
        print("VULKAN VALIDATION: %\n", msg);
    }
    
    return VK_FALSE;
}


print_available_vulkan_extensions :: () {
    extension_count: u32;
    vkEnumerateInstanceExtensionProperties(null, *extension_count, null);
    extension_array := NewArray(extension_count, VkExtensionProperties);
    defer free(extension_array.data);
    vkEnumerateInstanceExtensionProperties(null, *extension_count, extension_array.data);
    print("Available extensions:\n");
    for extension_array print("    % (%)\n", to_string(it.extensionName.data), it.specVersion);
}

vkDestroyDebugReportCallbackEXT : PFN_vkDestroyDebugReportCallbackEXT;

init_vulkan :: () -> bool {
    result : VkResult = .ERROR_INITIALIZATION_FAILED;
    
    // Application Info
    app_info: VkApplicationInfo;
    app_info.sType              = .APPLICATION_INFO;
    app_info.pApplicationName   = "Vulkan example";
    app_info.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
    app_info.pEngineName        = "No Engine";
    app_info.engineVersion      = VK_MAKE_VERSION(1, 0, 0);
    app_info.apiVersion         = VK_API_VERSION_1_0;

    // Create Vulkan Instance
    create_info : VkInstanceCreateInfo;
    create_info.sType                   = .INSTANCE_CREATE_INFO;
    create_info.pApplicationInfo        = *app_info;

    #if !DEBUG {
        extensions: [2] *u8;
        extensions[0] = VK_KHR_SURFACE_EXTENSION_NAME.data;
        // @ToDo: Non-Windows version
        extensions[1] = VK_KHR_WIN32_SURFACE_EXTENSION_NAME.data;
    } else {
        #if OS == .WINDOWS {
            extensions: [3] *u8;
            extensions[0] = VK_KHR_SURFACE_EXTENSION_NAME.data;
            extensions[1] = VK_KHR_WIN32_SURFACE_EXTENSION_NAME.data;
            extensions[2] = VK_EXT_DEBUG_REPORT_EXTENSION_NAME.data;
        } else {
            extensions: [0] *u8;
            // @ToDo: Non-Windows version
            #assert(false);
        }
    }

    create_info.enabledExtensionCount   = extensions.count;
    create_info.ppEnabledExtensionNames = extensions.data;

    #if DEBUG {
        debug_create_info := create_info;
        debug_create_info.enabledLayerCount = 1;
        debug_create_info.ppEnabledLayerNames = (*u8).["VK_LAYER_LUNARG_standard_validation"].data;

        result = vkCreateInstance(*debug_create_info, null, *instance);
        if result == .SUCCESS {
            vkCreateDebugReportCallbackEXT  : PFN_vkCreateDebugReportCallbackEXT = xx vkGetInstanceProcAddr(instance, "vkCreateDebugReportCallbackEXT");
            vkDestroyDebugReportCallbackEXT = xx vkGetInstanceProcAddr(instance, "vkDestroyDebugReportCallbackEXT");
            vkDebugReportMessageEXT         : PFN_vkDebugReportMessageEXT = xx vkGetInstanceProcAddr(instance, "vkDebugReportMessageEXT");

            if vkCreateDebugReportCallbackEXT {
                debug_callback_create_info: VkDebugReportCallbackCreateInfoEXT;
                debug_callback_create_info.flags |= .ERROR_BIT_EXT;
                debug_callback_create_info.flags |= .WARNING_BIT_EXT;
                debug_callback_create_info.pfnCallback = debug_callback;

                vkCreateDebugReportCallbackEXT(instance, *debug_callback_create_info, null, *debug_callback_handle);
            }
        }
    }

    if result != .SUCCESS {
        result = vkCreateInstance(*create_info, null, *instance);
    }

    return result == .SUCCESS;
}


deinit_vulkan :: () {
    #if DEBUG {
        if vkDestroyDebugReportCallbackEXT && debug_callback_handle {
            vkDestroyDebugReportCallbackEXT(instance, debug_callback_handle, null);
        }
    }
    vkDestroyInstance(instance, null);
}

init_surface :: () -> bool {
    #if OS == .WINDOWS {
        my_hwnd := window;
        surfaceCreateInfo: VkWin32SurfaceCreateInfoKHR; 
        surfaceCreateInfo.sType     = .WIN32_SURFACE_CREATE_INFO_KHR;
        surfaceCreateInfo.hinstance = GetModuleHandleW(null);
        surfaceCreateInfo.hwnd      = my_hwnd;
        result := vkCreateWin32SurfaceKHR(instance, *surfaceCreateInfo, null, *surface);
        return result == .SUCCESS;
    } else {
        // @ToDo
        #assert(false);
        return false;
    }
}

deinit_surface :: () {
    vkDestroySurfaceKHR(instance, surface, null);
}

init_device :: () -> bool {
    // Picking physical device
    //
    MAX_DEVICE_COUNT :: 8;
    MAX_QUEUE_COUNT  :: 4;   // ATM there should be at most transfer, graphics, compute, graphics+compute families

    device_handles         : [MAX_DEVICE_COUNT] VkPhysicalDevice;
    queue_family_properties: [MAX_QUEUE_COUNT] VkQueueFamilyProperties;
    physical_device_count  : u32;

    vkEnumeratePhysicalDevices(instance, *physical_device_count, null);
    physical_device_count = min(physical_device_count, MAX_DEVICE_COUNT);
    vkEnumeratePhysicalDevices(instance, *physical_device_count, device_handles.data);

    print("Physical device count: %\n", physical_device_count);

    for i: 0..physical_device_count-1 {
        queue_family_count: u32 = 0;
        vkGetPhysicalDeviceQueueFamilyProperties(device_handles[i], *queue_family_count, null);
        queue_family_count = min(queue_family_count, MAX_QUEUE_COUNT);
        vkGetPhysicalDeviceQueueFamilyProperties(device_handles[i], *queue_family_count, queue_family_properties.data);

        print("Physical device % supports % queues families.\n", i, queue_family_count);

        for j: 0..queue_family_count-1 {
            supports_present := VK_FALSE;
            vkGetPhysicalDeviceSurfaceSupportKHR(device_handles[i], j, surface, *supports_present);

            print("Queue family properites: %.\n", queue_family_properties[j]);

            if supports_present && (queue_family_properties[j].queueFlags & .GRAPHICS_BIT) {
                queue_family_index = j;
                physical_device = device_handles[i];
                print("Queue family % supports present and graphics.\n", j);
                break;
            }
        }

        if (physical_device) {
            break;
        }
    }

    // Logical device
    //
    queue_create_info: VkDeviceQueueCreateInfo;
    queue_create_info.sType = .DEVICE_QUEUE_CREATE_INFO;
    queue_create_info.queueFamilyIndex = queue_family_index;
    queue_create_info.queueCount = 1;
    queue_create_info.pQueuePriorities = float.[1.0].data;

    device_create_info: VkDeviceCreateInfo;
    {
        using device_create_info;
        exexe: [1] *u8;
        exexe[0] = VK_KHR_SWAPCHAIN_EXTENSION_NAME.data;
        queueCreateInfoCount    = 1;
        pQueueCreateInfos       = *queue_create_info;
        enabledLayerCount       = 0;
        ppEnabledLayerNames     = null;

        enabledExtensionCount   = exexe.count;
        ppEnabledExtensionNames = exexe.data;
        pEnabledFeatures = null;
    }
    
    result := vkCreateDevice(physical_device, *device_create_info, null, *device);

    vkGetDeviceQueue(device, queue_family_index, queueIndex=0, *queue);

    return result == .SUCCESS;
}

deinit_device :: () {
    vkDestroyDevice(device, null);
}


MAX_PRESENT_MODE_COUNT :: 6; // At the moment in spec
MAX_SWAPCHAIN_IMAGES   :: 3;
swapchain: VkSwapchainKHR;
swapchainImageCount: u32;
swapchainImages: [MAX_SWAPCHAIN_IMAGES] VkImage;
swapchainExtent: VkExtent2D;
surfaceFormat  : VkSurfaceFormatKHR;

init_swapchain :: () -> bool {
    PRESENT_MODE_MAILBOX_IMAGE_COUNT :u32: 3;
    PRESENT_MODE_DEFAULT_IMAGE_COUNT :u32: 2;

    // Use first available format
    formatCount : u32 = 1;
    vkGetPhysicalDeviceSurfaceFormatsKHR(physical_device, surface, *formatCount, null); // suppress validation layer
    vkGetPhysicalDeviceSurfaceFormatsKHR(physical_device, surface, *formatCount, *surfaceFormat);
    surfaceFormat.format = ifx surfaceFormat.format == .UNDEFINED then .B8G8R8A8_UNORM else surfaceFormat.format;

    presentModeCount : u32 = 0;
    vkGetPhysicalDeviceSurfacePresentModesKHR(physical_device, surface, *presentModeCount, null);
    presentModes: [MAX_PRESENT_MODE_COUNT]VkPresentModeKHR;
    presentModeCount = min(presentModeCount, MAX_PRESENT_MODE_COUNT);
    vkGetPhysicalDeviceSurfacePresentModesKHR(physical_device, surface, *presentModeCount, presentModes.data);

    presentMode : VkPresentModeKHR = .FIFO_KHR;   // always supported.
    for 0..presentModeCount-1 {
        if presentModes[it] == .MAILBOX_KHR {
            presentMode = .MAILBOX_KHR;
            break;
        }
    }
    
    swapchainImageCount = ifx presentMode == .MAILBOX_KHR  then PRESENT_MODE_MAILBOX_IMAGE_COUNT else  PRESENT_MODE_DEFAULT_IMAGE_COUNT;

    surfaceCapabilities: VkSurfaceCapabilitiesKHR;
    vkGetPhysicalDeviceSurfaceCapabilitiesKHR(physical_device, surface, *surfaceCapabilities);

    swapchainExtent = surfaceCapabilities.currentExtent;
    if swapchainExtent.width == U32_MAX {
        swapchainExtent.width  = clamp(width, surfaceCapabilities.minImageExtent.width, surfaceCapabilities.maxImageExtent.width);
        swapchainExtent.height = clamp(height, surfaceCapabilities.minImageExtent.height, surfaceCapabilities.maxImageExtent.height);
    }

    swapChainCreateInfo: VkSwapchainCreateInfoKHR;
    the_surface := surface;  // No way yet to avoid importing this with 'using'. Should fix that!
    {
        swapChainCreateInfo.surface = the_surface;

        using swapChainCreateInfo;
        minImageCount               = swapchainImageCount;
        imageFormat                 = surfaceFormat.format;
        imageColorSpace             = surfaceFormat.colorSpace;
        imageExtent                 = swapchainExtent;
        imageArrayLayers            = 1; // 2 for stereo
        imageUsage                  |= .COLOR_ATTACHMENT_BIT;
        imageUsage                  |=  .TRANSFER_DST_BIT;
        imageSharingMode            = .EXCLUSIVE;
        preTransform                = surfaceCapabilities.currentTransform;
        compositeAlpha              = .OPAQUE_BIT_KHR;
        presentMode                 = presentMode;
        clipped                     = VK_TRUE;
    }
    
    result := vkCreateSwapchainKHR(device, *swapChainCreateInfo, null, *swapchain);
    if result != .SUCCESS {
        return false;
    }

    vkGetSwapchainImagesKHR(device, swapchain, *swapchainImageCount, null);
    vkGetSwapchainImagesKHR(device, swapchain, *swapchainImageCount, swapchainImages.data);

    return true;
}

deinit_swapchain :: () {
    vkDestroySwapchainKHR(device, swapchain, null);
}



FRAME_COUNT :: 2;
frame_index := 0;
commandPool   : VkCommandPool;
commandBuffers: [FRAME_COUNT]VkCommandBuffer;
frameFences   : [FRAME_COUNT]VkFence; // Create with VK_FENCE_CREATE_SIGNALED_BIT.
imageAvailableSemaphores: [FRAME_COUNT]VkSemaphore;
renderFinishedSemaphores: [FRAME_COUNT]VkSemaphore;


init_render :: () {
    log("init_render\n");

    commandPoolCreateInfo: VkCommandPoolCreateInfo;
    commandPoolCreateInfo.flags            = .RESET_COMMAND_BUFFER_BIT;
    commandPoolCreateInfo.queueFamilyIndex = queue_family_index;
    vkCreateCommandPool(device, *commandPoolCreateInfo, null, *commandPool);

    commandBufferAllocInfo: VkCommandBufferAllocateInfo;
    commandBufferAllocInfo.commandPool        = commandPool;
    commandBufferAllocInfo.level              = .PRIMARY;
    commandBufferAllocInfo.commandBufferCount = FRAME_COUNT;

    vkAllocateCommandBuffers(device, *commandBufferAllocInfo, commandBuffers.data);

    semaphoreCreateInfo: VkSemaphoreCreateInfo;
    vkCreateSemaphore(device, *semaphoreCreateInfo, null, *imageAvailableSemaphores[0]);
    vkCreateSemaphore(device, *semaphoreCreateInfo, null, *imageAvailableSemaphores[1]);
    vkCreateSemaphore(device, *semaphoreCreateInfo, null, *renderFinishedSemaphores[0]);
    vkCreateSemaphore(device, *semaphoreCreateInfo, null, *renderFinishedSemaphores[1]);

    fenceCreateInfo: VkFenceCreateInfo;
    fenceCreateInfo.flags = .SIGNALED_BIT;

    vkCreateFence(device, *fenceCreateInfo, null, *frameFences[0]);
    vkCreateFence(device, *fenceCreateInfo, null, *frameFences[1]);
}

deinit_render :: () {
    log("deinit_render\n");

    vkDeviceWaitIdle(device);
    vkDestroyFence(device, frameFences[0], null);
    vkDestroyFence(device, frameFences[1], null);
    vkDestroySemaphore(device, renderFinishedSemaphores[0], null);
    vkDestroySemaphore(device, renderFinishedSemaphores[1], null);
    vkDestroySemaphore(device, imageAvailableSemaphores[0], null);
    vkDestroySemaphore(device, imageAvailableSemaphores[1], null);
    vkDestroyCommandPool(device, commandPool, null);
}



draw_frame :: () {
    //print("Frame %\n", frame_index);

    u64_low, u64_high := get_integer_range(u64);

    frame_index += 1;
    index := frame_index % FRAME_COUNT;
    vkWaitForFences(device, 1, *frameFences[index], VK_TRUE, u64_high);
    vkResetFences(device, 1, *frameFences[index]);

    imageIndex: u32;
    vkAcquireNextImageKHR(device, swapchain, u64_high, imageAvailableSemaphores[index], VK_NULL_HANDLE, *imageIndex);

    beginInfo: VkCommandBufferBeginInfo;
    beginInfo.flags = .ONE_TIME_SUBMIT_BIT;

    vkBeginCommandBuffer(commandBuffers[index], *beginInfo);

    // @@ ...


    // Clear frame.
    subResourceRange : VkImageSubresourceRange;
    {
        using subResourceRange;
        aspectMask     = .COLOR_BIT;
        baseMipLevel   = 0;
        levelCount     = VK_REMAINING_MIP_LEVELS;
        baseArrayLayer = 0;
        layerCount     = VK_REMAINING_ARRAY_LAYERS;
    }
    
    // Change layout of image to be optimal for clearing
    imgMemoryBarrier : VkImageMemoryBarrier;
    {
        using imgMemoryBarrier;
        srcAccessMask       = 0;
        dstAccessMask       = .TRANSFER_WRITE_BIT;
        oldLayout           = .UNDEFINED;
        newLayout           = .TRANSFER_DST_OPTIMAL;
        srcQueueFamilyIndex = queue_family_index;
        dstQueueFamilyIndex = queue_family_index;
        image               = swapchainImages[imageIndex];
        subresourceRange    = subResourceRange;
    }
    
    vkCmdPipelineBarrier(commandBuffers[index], .TRANSFER_BIT, .TRANSFER_BIT, 
                         0, 0, null, 0, null, 1, *imgMemoryBarrier);

    clearColor : VkClearColorValue;
    {
        // Pick a color with which to clear the screen.
        color1 := Vector4.{1,  1, 0, 1};
        color2 := Vector4.{.5, 0, 1, 1};

        now := seconds_since_init();
        t := cos(cast(float) now) * .5 + .5;
        Clamp(*t, 0, 1);
        color := lerp(color1, color2, t);
        clearColor._float32 = color.component;
        // clearColor.float32 = float.[1, 1, 0, 1];
    }
    
    vkCmdClearColorImage(commandBuffers[index], swapchainImages[imageIndex], .TRANSFER_DST_OPTIMAL, *clearColor, 1, *subResourceRange);

    // Change layout of image to be optimal for presenting
    imgMemoryBarrier.srcAccessMask = .TRANSFER_WRITE_BIT;
    imgMemoryBarrier.dstAccessMask = .MEMORY_READ_BIT;
    imgMemoryBarrier.oldLayout     = .TRANSFER_DST_OPTIMAL;
    imgMemoryBarrier.newLayout     = .PRESENT_SRC_KHR;
    //imgMemoryBarrier.srcQueueFamilyIndex = queue_family_index;
    //imgMemoryBarrier.dstQueueFamilyIndex = queue_family_index;
    //imgMemoryBarrier.image = swapchainImages[imageIndex];
    //imgMemoryBarrier.subresourceRange = subResourceRange;
    vkCmdPipelineBarrier(commandBuffers[index], .TRANSFER_BIT, .BOTTOM_OF_PIPE_BIT,
        0, 0, null, 0, null, 1, *imgMemoryBarrier);


    vkEndCommandBuffer(commandBuffers[index]);

    submitInfo: VkSubmitInfo; 
    submitInfo.waitSemaphoreCount   = 1;
    submitInfo.pWaitSemaphores      = *imageAvailableSemaphores[index];
    submitInfo.pWaitDstStageMask    = VkPipelineStageFlags.[.COLOR_ATTACHMENT_OUTPUT_BIT].data;
    submitInfo.commandBufferCount   = 1;
    submitInfo.pCommandBuffers      = *commandBuffers[index];
    submitInfo.signalSemaphoreCount = 1;
    submitInfo.pSignalSemaphores    = *renderFinishedSemaphores[index];
    vkQueueSubmit(queue, 1, *submitInfo, frameFences[index]);

    // Present.
    presentInfo: VkPresentInfoKHR;
    presentInfo.waitSemaphoreCount = 1;
    presentInfo.pWaitSemaphores    = *renderFinishedSemaphores[index];
    presentInfo.swapchainCount     = 1;
    presentInfo.pSwapchains        = *swapchain;
    presentInfo.pImageIndices      = *imageIndex;
    vkQueuePresentKHR(queue, *presentInfo);
}


