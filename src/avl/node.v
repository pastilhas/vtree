module avl

@[heap]
struct AVLNode[T] {
	data &T
mut:
	left   &AVLNode[T] = unsafe { 0 }
	right  &AVLNode[T] = unsafe { 0 }
	parent &AVLNode[T] = unsafe { 0 }
	bf     i8
}

fn new_node[T](k &T) &AVLNode[T] {
	return &AVLNode[T]{
		data: unsafe { k }
	}
}
