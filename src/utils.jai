align_next_power_of_2 :: (x: u64, power: u64) -> u64 {
	assert((power & (power - 1)) == 0, "Value given is not a power of 2");
	
	return (x + power - 1) & ~(power - 1);
}

get :: inline (data: *[..] $T) -> *T {
	array_add(data);
	item := *data[data.count - 1];
	return cast(*T, item);
}

get :: inline (pool: *Flat_Pool, $type: Type, $initialized := true) -> *type {
	bytes := get(pool, size_of(type));
	
	#if initialized {
		#if initializer_of(type) inline initializer_of(type)(bytes);
		else memset(bytes, 0, size_of(type));
	}
	
	return cast(*type, bytes);
}

get :: inline (pool: *Flat_Pool, data: $T) -> *T {
	bytes := get(pool, size_of(T));
	memcpy(bytes, *data, size_of(T));
	return cast(*T, bytes);
}

get_array :: inline (pool: *Flat_Pool, $type: Type, count: s64, $initialized := true) -> [] type {
	bytes := get(pool, size_of(type) * count);
	#if initialized {
		for * cast(*[] type, bytes).*{
			#if initializer_of(type) inline initializer_of(type)(it);
				else memset(bytes, 0, size_of(type));
		}
	}
	return [] type.{count, bytes};
}

get_array :: (pool: *Flat_Pool, args: ..$T) -> [] T{
	data := [] T.{args.count, get(pool, args.count * size_of(T))};
	for args {
		data[it_index] = it;
	}
	return data;
}

get_array :: (pool: *Flat_Pool, array: *[] $T) -> [] T{
	data := [] T.{array.count, get(pool, array.count * size_of(T))};
	memcpy(data.data, array, array.count * size_of(T));
	return data;
}

clamp_hi :: inline (val: $T, max: T) -> T {
	return clamp(val, val, max);
}

clamp_lo :: inline (val: $T, min: T) -> T {
	if val < min return min;
	else return val;
}

vk_assert :: val => assert(val == .SUCCESS);

get_instance_proc_add :: (inst: VkInstance, entry: string) #expand {
	#insert #run tprint("`% : PFN_% = xx vkGetInstanceProcAddr(inst, \"%\");", entry, entry, entry);
}

align_of :: ($T: Type) -> s64 #expand {
    return #run -> s64 {
        info := type_info(struct{ p: u8; t: T; });
        return info.members[1].offset_in_bytes;
    };
}

NULL_HANDLE :: VK_NULL_HANDLE;

f32 :: float32;
f64 :: float64;

new :: New;
push :: array_add;
array_new :: NewArray;
init :: init_string_builder;


Color3 :: struct {
    r, g, b: u8;

}

Color4 :: struct {
    r, g, b, a: u8;
}
