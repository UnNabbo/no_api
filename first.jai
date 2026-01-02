#if #exists(JAILS_DIAGNOSTICS_BUILD) options.output_type = .NO_OUTPUT;

#import "Basic";
#import "String";
#import "Compiler";
#import "File";
#import "File_Utilities";
#import "Process";
#import "Metaprogram_Plugins";


plugins: [..]*Metaprogram_Plugin;

start_workspace :: (w: Workspace) #compile_time {
    start := plugins.count;
    #insert #run,stallable -> string {
        sb: String_Builder;
        for plugin_names {
            found, name, params := split_from_left(it, #char "(");
            if found then { params.data -= 1; params.count += 1; } else name = it;
            print(*sb, "P%1 :: #import \"%2\"%3; array_add(*plugins, P%1.get_plugin());\n", it_index, name, params);
        }
        return builder_to_string(*sb);
    };
    
    flags: Intercept_Flags;
    for start..plugins.count-1 {
        p := plugins[it];
        p.workspace = w;
        if   p.before_intercept
        then p.before_intercept(p, *flags);
    }

    compiler_begin_intercept(w, flags);
    for start..plugins.count-1 {
        p := plugins[it];
        if   p.add_source
        then p.add_source(p);
    }
}

compile_workspaces :: (workspaces: ..Workspace) -> bool #compile_time {
    completed := 0;
    ok := true;
    while true {
        m := compiler_wait_for_message();
        for plugins if it.workspace == m.workspace && it.message then it.message(it, m);
        if m.kind == .COMPLETE {
            completed += 1;
            complete  := cast(*Message_Complete) m;
            if complete.error_code != .NONE then ok = false;
            if completed >= workspaces.count break;
        }
    }
    
    for workspaces compiler_end_intercept(it);
    for plugins if it.finish   then it.finish(it);
    for plugins if it.shutdown then it.shutdown(it);
    for workspaces compiler_destroy_workspace(it);
    array_reset_keeping_memory(*plugins);
    
    return ok;
}

to_run: [..] string;

create_workspace :: (file: string, src_path := "examples", run := false) -> Workspace{
	w := compiler_create_workspace(file);
	using options := get_build_options(w);
        
	output_executable_name = file;
	text_output_flags = 0;
	dead_code_elimination = .NONE;
	
	import_paths : [..] string;
    import_paths.allocator = temp;
    array_add(*import_paths, ..options.import_path);
    import_path = import_paths;
	
	debug := true;
	build_path := tprint("out/%/debug", file);
	for compile_time_command_line {
		if it == {
			case "debug";
				print("Building in debug mode\n");
				options.backend = .X64;
				set_optimization(*options, .DEBUG);
			case "release";
				print("Building in release mode\n");
				build_path = "out/release";
				options.backend = .LLVM;
				set_optimization(*options, .VERY_OPTIMIZED);
				debug = false;
		}
	}

	output_path = build_path;
	make_directory_if_it_does_not_exist(output_path, true);
	copy_file("modules/vulkan_memory_allocator/windows/Vulkan_Memory_Allocator.dll", tprint("%/Vulkan_Memory_Allocator.dll", output_path));
	copy_file("modules/slang/lib/win/slang-compiler.dll", tprint("%/slang-compiler.dll", output_path));
	set_build_options(options, w);

	if run {
		exe_full_name := tprint("%/%.exe", output_path, output_executable_name);
		for exe_full_name if it == #char "/" then exe_full_name[it_index] = #char "\\";
		array_add(*to_run, exe_full_name);
	}
	
	start_workspace(w);
	
	add_build_string("Build_Type :: enum u8{DEBUG; RELEASE;}", w);
	add_build_string(tprint("BUILD_TYPE :: %;", ifx debug then "Build_Type.DEBUG" else "Build_Type.RELEASE"), w);
	add_build_file(tprint("%/%.jai", src_path, file), w);

	return w;
}

plugin_names :: string.[];
#run {
	set_working_directory(#filepath);
	defer set_build_options_dc(.{do_output=false});
	
	args := get_build_options().compile_time_command_line;
	run_all := true;
	for args {
		if it == {
			case "no_run";
				run_all = false;
		}
	}

	run := false;
	w1 := create_workspace("playground", run = run);
	w2 := create_workspace("hello_triangle", run = true);
	w3 := create_workspace("hello_compute", run = run);
	w4 := create_workspace("sponza", "examples/sponza", run = run);
  
	if compile_workspaces(w1, w2, w3, w4) && run_all{
		for to_run  {
			process: Process;
			success := create_process(*process, "wt", "-d", #filepath, "cmd", "/k", it, "&", "exit", kill_process_if_parent_exits = false);
		}
	}
}
