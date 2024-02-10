module bst

@[heap]
struct Node[T] {
	data &T
mut:
	left  &Node[T] = unsafe { 0 }
	right &Node[T] = unsafe { 0 }
}

fn new_node[T](k &T) &Node[T] {
	return &Node[T]{
		data: unsafe { k }
	}
}
