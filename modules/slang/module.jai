#if OS == .WINDOWS {
    #load "windows.jai";
} else #if OS == .LINUX {
    #load "linux.jai";
} else {
    #assert false "Unsupported OS for Slang";
}

#if OS == .WINDOWS {
    slang_compiler :: #library,no_dll,link_always "lib/win/slang-compiler";
} else #if OS == .LINUX {
    libslang :: #library "lib/linux/libslang";
}

