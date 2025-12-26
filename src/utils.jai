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

align_to :: (value: $T, alignment: T) -> T{
  return (value + alignment - 1) & ~(alignment - 1);
}


Interval_Table :: struct($range_type: Type, $value_type: Type){
	Node :: struct {
		height: s64 = 1;
		left, right, parent: *Node;
		min, max: range_type;
		value: value_type;
	}

	root: *Node;
	pool: Flat_Pool;
}

add :: (using tree: *Interval_Table, min_value: tree.range_type, max_value: tree.range_type){
	value: value_type;
	add(tree, min_value, max_value, value);
}

add :: (using tree: *Interval_Table, min_value: tree.range_type, max_value: tree.range_type, value: tree.value_type){
	node := get(*tree.pool, Node);
	node.min = min_value;
	node.max = max_value - 1;
	node.value = value;
	
	if !tree.root {
		tree.root = node;
		tree.root.height = 1;
	}
	else insert(tree, node);
}

delete :: (using tree: *Interval_Table, min_value: tree.range_type, max_value: tree.range_type){
	node := root;
	while node {
		if min_value == node.min && max_value == node.max{
			delete(tree, node);
		}
		
		if min_value > node.max{
			node = node.right;
			continue;
		}

		if max_value < node.min{
			node = node.left;
			continue;
		}
	}
}

find :: (using tree: *Interval_Table, value: tree.range_type) -> bool, tree.value_type {
	node := root;
	while node {
		if value >= node.min && value <= node.max{
			return true, node.value; 
		}
		
		if value > node.max{
			node = node.right;
			continue;
		}

		if value < node.min{
			node = node.left;
			continue;
		}
	}
	v: tree.value_type;
	return false, v;
}

find_ptr :: (using tree: *Interval_Table, value: tree.range_type) -> *tree.value_type {
	node := root;
	while node {
		if value >= node.min && value <= node.max{
			return *node.value; 
		}
		
		if value > node.max{
			node = node.right;
			continue;
		}

		if value < node.min{
			node = node.left;
			continue;
		}
	}
	return null;
}


#scope_file;


node_height :: node => ifx node then node.height else 0;
node_balance :: node => ifx node then node_height(node.left) - node_height(node.right) else 0;

rotate_left ::  (using tree: *Interval_Table, x: *tree.Node) -> *tree.Node{
	y := x.right;
	pivot := y.left;

	y.left = x;
	x.right = pivot;
		
	x.height = max(node_height(x.left), node_height(x.right)) + 1;
	y.height = max(node_height(y.left), node_height(y.right)) + 1;

	if x.parent {
		if x == x.parent.left then x.parent.left = y;
		if x == x.parent.right then x.parent.right = y;
	}
		
	y.parent = x.parent;
	x.parent = y;
	if x == root then root = y;
	return y;
}

rotate_right ::  (using tree: *Interval_Table,y: *tree.Node)  -> *tree.Node{
	x := y.left;
	pivot := x.right;

	x.right = y;
	y.left = pivot;
		
	y.height = max(node_height(y.left), node_height(y.right)) + 1;
	x.height = max(node_height(x.left), node_height(x.right)) + 1;

	if y.parent {
		if y == y.parent.left then y.parent.left = x;
		if y == y.parent.right then y.parent.right = x;
	}
		
	x.parent = y.parent;
	y.parent = x;
	if y == root then root = x;
	return x;
}
	
delete :: (using tree: *Interval_Table, node: *tree.Node, at_node: *tree.Node = null) -> bool{
	at := ifx at_node then at_node else root;

	if node != at_node{
		if node.min >= at.max {
			if at.right then return delete(tree, node, at.right);
		}
	
		if node.max <= at.min{
			if at.left then return delete(tree, node, at.left);
		}
	}else{
		if !node.left || !node.right{
			orphan := ifx node.left then node.right else node.left;
			if orphan{
				orphan.parent = node.parent;
				if node.parent{
					if node == node.parent.left then node.parent.left = orphan;
					if node == node.parent.right then node.parent.right = orphan;
				} else {
					root = orphan;
				}
			}
		}else if node.left && node.right {
			node.height = max(node_height(node.left), node_height(node.right)) + 1;
			balance := node_balance(node);
			if balance > 1 && node_balance(root.left) >= 0 then rotate_right(root);
			if balance < -1 && node_balance(root.right) <= 0 then rotate_left(root);
			
			if balance > 1 && node_balance(root.left) < 0 {
				root.left =  rotate_left(root.left);
				rotate_right(root);
			}
			if balance < -1 && node_balance(root.right) > 0{
				root.right = rotate_right(root.right);
				rotate_left(root);
			}
		}
		return true;
	}
	return false;
}


insert :: (using tree: *Interval_Table, node: *tree.Node, at_node: *tree.Node = null){
	at := ifx at_node then at_node else root;
	assert(node.min != at.min || node.max != at.max, "Cannot insert a duplicate interval(%, %) - (%, %)", node.min, node.max, at.min, at.max);
	assert(node.min > at.min || node.max < at.max, "Cannot insert an interval containing another interval");
	assert(node.min < at.min || node.max > at.max, "Cannot insert an overlapping interval");
	if node.min >= at.max{
		if !at.right {
			at.right = node;
			node.parent = at;
		} else insert(tree, node, at.right);
	}
	
	if node.max <= at.min{
		if !at.left {
			at.left = node;
			node.parent = at;
		} else insert(tree, node, at.left);
	}

	at.height = max(node_height(at.left), node_height(at.right)) + 1;
	balance := node_height(at.left) - node_height(at.right);
	if balance == 0 then return;
	if balance > 1 && node.max <= at.min{
		rotate_right(tree, at);
	}
	if balance < -1 && node.min >= at.max  {
		rotate_left(tree, at);
	}
	if balance > 1 && !(node.max <= at.min){
		at.left = rotate_left(tree, at.left);
		rotate_right(tree, at);
	}
	if balance < -1 && !(node.min >= at.max)  {
		at.right = rotate_right(tree, at.right);
		rotate_left(tree, at);
	}
}
