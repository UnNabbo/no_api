// MIT License - Copyright (c) 2022 Hamad Almamari
// Tested with vulkan 1.0 and 1.2
// You can use this file to generate any version of vulkan bindings.
// You only need to set the vulkan.h and vulkan lib paths.

// config
AT_COMPILE_TIME   :: true;
vulkan_h_location :: "source/vulkan.h";

// if the lib path is empty system_library will be used.
// On MacOS, it will try to get the path from the environement variable.
#if OS == .WINDOWS {
    vulkan_lib_path :: "win";
}  else {
    vulkan_lib_path :: "";
}


#if AT_COMPILE_TIME {
    #run,stallable {
        set_build_options_dc(.{do_output=false});
        if !generate_bindings() {
            compiler_set_workspace_status(.FAILED);
        }
    }
} else {
    #import "System";

    main :: () {
        set_working_directory(path_strip_filename(get_path_of_running_executable()));
        if !generate_bindings() {
            exit(1);
        }
    }
}

//--------------------

OMIT_LIST :: string.[
    // These are defined manually:
    "VK_NULL_HANDLE",
    "VK_TRUE",
    "VK_FALSE",
    "VK_WHOLE_SIZE",
    "VK_ATTACHMENT_UNUSED",
    "VK_QUEUE_FAMILY_IGNORED",
    "VK_REMAINING_ARRAY_LAYERS",
    "VK_REMAINING_MIP_LEVELS",
    "VK_SUBPASS_EXTERNAL",
    "VK_MAX_PHYSICAL_DEVICE_NAME_SIZE",
    "VK_UUID_SIZE",
    "VK_MAX_MEMORY_TYPES",
    "VK_MAX_MEMORY_HEAPS",
    "VK_MAX_EXTENSION_NAME_SIZE",
    "VK_MAX_DESCRIPTION_SIZE",
    // Vulkan 1.3 functions that exist on Linux but are not part of our Windows version:
    "vkGetPhysicalDeviceSurfaceCapabilities2KHR",
    "vkGetPhysicalDeviceSurfaceFormats2KHR",
];

generate_bindings :: () -> bool {
    output_filename: string;
    options: Generate_Bindings_Options;
    {
        using options;

        #if OS == .WINDOWS {
            array_add(*libnames, "vulkan-1");
            array_add(*extra_clang_arguments, "-x", "c", "-DWIN32_LEAN_AND_MEAN");
            output_filename  = "generated_windows.jai";
        } else #if OS == .LINUX {
            array_add(*system_library_names, "libvulkan.so.1");
            output_filename  = "generated_linux.jai";
        } else #if OS == .MACOS {
            POSIX :: #import "POSIX";
			vulkan_sdk_path := to_string(POSIX.getenv("VULKAN_SDK"));
			if !vulkan_sdk_path then sdk_error_and_quit();

            vulkan_library_path := tprint("%/lib/libvulkan.1.dylib", vulkan_sdk_path);

            array_add(*libnames, vulkan_library_path);
            output_filename  = "generated_macos.jai";
        } else {
            assert(false);
        }

        if vulkan_lib_path then array_add(*libpaths, vulkan_lib_path);

        array_add(*source_files, vulkan_h_location);

        generate_library_declarations = true;
 

        visitor     = vulkan_visitor;
        log_stripped_declarations = false;
        generate_compile_time_struct_checks = false;
    }

    init_string_builder(*enumeration_wrapper_builder);

    bindings_builder, success := generate_bindings(options, log_results = true);
    if !success return false;

    append(*bindings_builder, "\n#import \"Basic\";\n\n#scope_export\n\n// Enumeration helpers\n\n");
    append_and_steal_buffers(*bindings_builder, *enumeration_wrapper_builder);

    success = write_entire_file(output_filename, *bindings_builder);
    if !success {
        log_error("Could not write generated output to \"%\"", output_filename);
        return false;
    }
    log("\nOK! generated '%'", output_filename);
    return true;
}

available_flag_bits: Table(string, *Enum);
struct_type_decl: *Enum;

enumeration_wrapper_builder: String_Builder;

vulkan_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
    // Omit header definitions (ex: VULKAN_H_)
    if decl.kind == .MACRO_DEFINITION && ends_with(decl.name, "_H_") {
        // print("MACRO_DEFINITION removed: %\n", decl.name);
        decl.decl_flags |= .OMIT_FROM_OUTPUT;
        return .STOP;
    }

    // Omit our OMIT_LIST
    if !parent_decl && array_find(OMIT_LIST, decl.name) {
        //print("OMIT_LIST: %\n", decl.name);
        decl.decl_flags |= .OMIT_FROM_OUTPUT;
        return .STOP;
    }

    if decl.kind == .ENUM {
        en := cast(*Enum)decl;
        if en.name == "VkStructureType" {
            struct_type_decl = en; // Save for later
        }

        // Almost all enums should be unsigned
        if en.type && decl.name != "VkResult" {
            if en.type.size == {
                case 1;
                    en.type = context.generator.type_def_u8;
                case 2;
                    en.type = context.generator.type_def_u16;
                case 4;
                    en.type = context.generator.type_def_u32;
                case 8;
                    en.type = context.generator.type_def_u64;
            }
        }

        if contains(decl.name, "FlagBits") {
            en.flags |= .IS_ENUM_FLAGS;
            en.flags |= .VALUES_IN_HEX;

            // Remember this so we can replace the generic VkFlags aliases with the actual enum_flag's type below. :VkFlags
            table_add(*available_flag_bits, decl.name, en);
        }
    }

    // Replace typedef which has "VkFlags" as value. :VkFlags
    // VkAccessFlags :: VkFlags   ->   VkAccessFlags :: VkAccessFlagBits;
    // We don't change the name of the FlagBits enum directly because both the ...FlagBits and the ...Flags aliases are used in declarations.
    if decl.kind == .TYPEDEF && decl.type.type_of_typedef &&  decl.type.type_of_typedef.name == "VkFlags" {
        //print("TYPEDEF(VkFlags):%\n", << decl.name);
        flags_name := replace(decl.name, "Flags", "FlagBits");
        found, enum_decl := table_find_new(*available_flag_bits, flags_name);
        if found {
            type := New(CType);
            type.type_of_enum = enum_decl;
            type.size = enum_decl.type.size;
            decl.type = type;
        }
    }

    // Set the default value for sType.
    if parent_decl && parent_decl.kind == .STRUCT && parent_decl.name != "VkBaseInStructure" && parent_decl.name != "VkBaseOutStructure" &&
            decl.kind == .DECLARATION && decl.name == "sType" {

        enum_value_name := get_sType_default_value_from_struct_name(parent_decl.name);
        enum_value: *Enum.Enumerate;
        for * struct_type_decl.enumerates {
            if it.output_name == enum_value_name {
                enum_value = it;
                break;
            }
        }
        assert(enum_value != null, "Could not find % enum value for \"%\"", struct_type_decl.name, enum_value_name);

        literal := New(Literal);
        literal.literal_kind = .ENUM;
        literal.enum_type = struct_type_decl;
        literal.enum_value = enum_value;
        decl.expression = literal;
    }

    if decl.kind == .FUNCTION {
        function := cast(*Function) decl;
        maybe_add_enumeration_wrapper(*enumeration_wrapper_builder, function);
    }

    return .RECURSE;
}

maybe_add_enumeration_wrapper :: (builder: *String_Builder, function: *Function) {
    if function.decl_flags & .OMIT_FROM_OUTPUT return;

    func_type := function.type.type_of_function;
    assert(func_type != null);

    if func_type.arguments.count < 2 return;

    count_arg := func_type.arguments[func_type.arguments.count - 2];
    data_arg := func_type.arguments[func_type.arguments.count - 1];

    // Make sure that the count is a *u32, that data is a pointer and that the return values is a VkResult (if present)
    if count_arg.type.pointer_to != context.generator.type_def_u32 return;
    if !data_arg.type.pointer_to return;
    assert(func_type.return_type != null);
    has_return_value := (func_type.return_type != context.generator.type_def_void);
    if has_return_value && get_type_name(func_type.return_type) != "VkResult" return;

    print_to_builder(builder, "% :: (", function.name);

    for i: 0..func_type.arguments.count - 3 {
        if i append(builder, ", ");
        arg := func_type.arguments[i];
        print_to_builder(builder, "%: ", arg.name);
        print_type_to_builder(builder, arg.type, null);
    }

    append(builder, ") -> [] ");
    print_type_to_builder(builder, data_arg.type.pointer_to, null);

    if has_return_value {
        append(builder, ", VkResult");
    }

    append(builder, " {\n");
    append(builder, "    count: u32;\n    data: [] ");
    print_type_to_builder(builder, data_arg.type.pointer_to, null);
    append(builder, ";\n");

    if has_return_value {
        append(builder, "    result: VkResult;\n");
    }

    print_call :: () #expand {
        append(builder, "    ");
        if has_return_value {
            append(builder, "result = ");
        }

        print_to_builder(builder, "%(", function.name);

        for 0..func_type.arguments.count - 3 {
            arg := func_type.arguments[it];
            print_to_builder(builder, "%, ", arg.name);
        }

        append(builder, "*count, data.data);\n");
    }

    print_call();

    if has_return_value {
        append(builder, "    if result return .[], result;\n");
    }

    append(builder, "    if count == 0 return .[]");
    if has_return_value {
        append(builder, ", .SUCCESS");
    }
    append(builder, ";\n");

    append(builder, "    data = NewArray(count, ");
    print_type_to_builder(builder, data_arg.type.pointer_to, null);
    append(builder, ", initialized = false);\n");

    print_call();

    append(builder, "    return data");
    if has_return_value {
        append(builder, ", result");
    }
    append(builder, ";\n}\n\n");
}

get_sType_default_value_from_struct_name :: (name: string) -> string {
    assert(name.count >= 3);

    is_upper :: (byte: u8) -> bool {
        if byte >= #char "A" && byte <= #char "Z" return true;
        return false;
    }

    is_num :: (byte: u8) -> bool {
        if byte >= #char "0" && byte <= #char "9" return true;
        return false;
    }

    builder: String_Builder;
    append(*builder, name[2]);

    for i:3..name.count-1 {
        if is_upper(name[i]) {
            is_first_uppercase := !is_upper(name[i-1]);
            is_end_of_uppercase_word := (i != name.count-1 && !is_upper(name[i+1]));
            is_bit_count := is_num(name[i-1]) && slice(name, i, 3) == "Bit";
            is_av1 := i >= 14 && slice(name, i - 1, 3) == "AV1";
            is_rgba := name[i] == #char "A" && i == 19 && slice(name, i - 3, 3) == "RGB";
            is_rgba10 := name[i] == #char "X" && i == 22 && slice(name, i - 6, 6) == "RGBA10";
            is_2_or_3D := name[i] == #char "D" && i >= 2 && (name[i - 1] == #char "2" || name[i - 1] == #char "3");

            if (is_first_uppercase || is_end_of_uppercase_word) && !is_bit_count && !is_av1 && !is_rgba && !is_rgba10 && !is_2_or_3D {
                append(*builder, #char "_");
            } else if (i >= 4 && slice(name, i-4, 4) == "AABB") { // Special case hack for names involing AABB
                append(*builder, #char "_");
            } else if (i == 38 && slice(name, i-4, 4) == "ASTC") {
                append(*builder, #char "_");
            }
            append(*builder, name[i]);
        } else if is_num(name[i]) {
            should_add_underscore := true;

            is_bit_after := i >= 17 && slice(name, i + 1, 3) == "Bit";
            is_int_before := i >= 27 && (slice(name, i - 4, 3) == "Int" || slice(name, i - 3, 3) == "Int");
            is_uint_before := i >= 29 && (slice(name, i - 4, 4) == "Uint" || slice(name, i - 5, 4) == "Uint");
            is_float_before := i >= 27 && (slice(name, i - 5, 5) == "Float" || slice(name, i - 6, 5) == "Float");
            is_rgba_before := i >= 20 && (slice(name, i - 4, 4) == "RGBA" || slice(name, i - 6, 4) == "RGBA");
            is_rgba10x_before := i >= 23 && slice(name, i - 7, 7) == "RGBA10X";
            is_h_before := i >= 14 && (name[i-1] == #char "H" || name[i-2] == #char "H" || name[i-3] == #char "H");
            is_av_before := i >= 15 && slice(name, i - 2, 2) == "AV";
            is_long_num_before := is_num(name[i - 1]);
            is_long_num_after := is_num(name[(i + 1) % name.count]);
            is_vulkan_version := i >= 22 && (slice(name, i - 6, 6) == "Vulkan" || slice(name, i - 7, 6) == "Vulkan");

            if is_bit_after || is_int_before || (is_float_before && is_long_num_after) || 
                is_h_before || is_av_before || is_uint_before || (is_long_num_before && !is_vulkan_version) || 
                is_rgba_before || is_rgba10x_before
            {
                should_add_underscore = false;
            }

            if should_add_underscore {
                append(*builder, #char "_");
            }
            append(*builder, name[i]);
        } else {
            append(*builder, to_upper(name[i]));
        }
    }

    return builder_to_string(*builder);
}

#scope_file
#import "Basic";
#import "Compiler";
#import "Check";
#import "Bindings_Generator";
#import "File";
#import "String";
#import "Hash_Table";

sdk_error_and_quit :: () {
	write_string("Vulkan SDK not found. Please ensure that it's installed on your system!\n", true);
	exit(1);
}
