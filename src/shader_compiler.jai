gpu_compile_shader :: (path: string, debug := false, is_file := true) -> bool, string {
	print_diagnostic_blob :: (blob: *Slang.IBlob) {
		log_error("[Slang][Error]: %", string.{
			data = Slang.ISlangBlob_getBufferPointer(blob),
			count = xx Slang.ISlangBlob_getBufferSize(blob),
		});
		Slang.ISlangUnknown_release(blob);
	}

    options: [..] Slang.CompilerOptionEntry;
    options.allocator = temp;
    array_add(*options, .{
        Slang.CompilerOptionName.Language, .{
            Slang.CompilerOptionValueKind.String, 0, 0, "slang", null
        }
    });
    array_add(*options, .{
        Slang.CompilerOptionName.Capability, .{
            Slang.CompilerOptionValueKind.Int, xx Slang.IGlobalSession_findCapability(slang_global_session, "spirv_1_6"), 0, null, null
        }
    });
    array_add(*options, .{
        Slang.CompilerOptionName.GLSLForceScalarLayout, .{
            Slang.CompilerOptionValueKind.Int, 1, 0, null, null
        }
    });
    array_add(*options, .{
        Slang.CompilerOptionName.EmitSpirvDirectly, .{
            Slang.CompilerOptionValueKind.Int, 1, 0, null ,null
        }
    });
	array_add(*options, .{
        Slang.CompilerOptionName.VulkanUseEntryPointName, .{
            Slang.CompilerOptionValueKind.Int, 1, 0, null ,null
        }
    });

	
    if debug then array_add(*options, .{
            Slang.CompilerOptionName.DebugInformation, .{
                Slang.CompilerOptionValueKind.Int, 2, 0, null, null
            }
    });

    target_desc: Slang.TargetDesc;
    target_desc.format = .SLANG_SPIRV;
    target_desc.profile = Slang.IGlobalSession_findProfile(slang_global_session, "sm_6_6");
    target_desc.forceGLSLScalarBufferLayout = true;
    target_desc.flags = xx Slang.SLANG_TARGET_FLAG.GENERATE_SPIRV_DIRECTLY;
    target_desc.compilerOptionEntries = options.data;
    target_desc.compilerOptionEntryCount = xx options.count;
	
    session_desc: Slang.SessionDesc;
    session_desc.targets = *target_desc;
    session_desc.targetCount = 1;
    session_desc.defaultMatrixLayoutMode = .ROW_MAJOR;
    session_desc.compilerOptionEntries = options.data;
    session_desc.compilerOptionEntryCount = xx options.count;

	if is_file{
		source_dir := path_strip_filename(path);
		search_paths := temp_c_string(source_dir);
		
		session_desc.searchPaths = *search_paths;
		session_desc.searchPathCount = 1;
	}		

    session: *Slang.ISession;
    Slang.IGlobalSession_createSession(slang_global_session, *session_desc, *session);
    if !session then return false, .{};
    defer Slang.ISlangUnknown_release(session);

    diagnostic_blob: *Slang.IBlob;
    slang_module := ifx is_file then Slang.ISession_loadModule(session, temp_c_string(path), *diagnostic_blob) else Slang.ISession_loadModuleFromSourceString(session, "_", "_.slang", temp_c_string(path), *diagnostic_blob);
    if diagnostic_blob then print_diagnostic_blob(diagnostic_blob);
    if !slang_module then return false, .{};

    component : *Slang.IComponentType =  slang_module;

    spirv_code: *Slang.IBlob;
    Slang.IComponentType_getTargetCode(component, 0, *spirv_code, *diagnostic_blob);
    if diagnostic_blob then print_diagnostic_blob(diagnostic_blob);

    spirv_code_raw := string.{
        data = Slang.ISlangBlob_getBufferPointer(spirv_code),
        count = cast(s64, Slang.ISlangBlob_getBufferSize(spirv_code))
    };

    memcpy(spirv_code_raw.data, Slang.ISlangBlob_getBufferPointer(spirv_code), spirv_code_raw.count);

    Slang.ISlangUnknown_release(spirv_code);

    return true, spirv_code_raw;
}

gpu_compile_and_create_shader :: (path: string, entry_point: string = "main", constants: ..Any, is_file := true) -> Shader_IR{
	_, data := gpu_compile_shader(path, is_file = is_file);
	return gpu_create_shader(data, entry_point, ..constants);
}
