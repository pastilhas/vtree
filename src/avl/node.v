module avl

@[heap]
struct Node[T] {
	data &T
mut:
	right &Node[T] = unsafe { 0 }
	left  &Node[T] = unsafe { 0 }
	bf    u8
}

fn new_node[T](k &T) &Node[T] {
	return &Node[T]{
		data: unsafe { k }
	}
}
