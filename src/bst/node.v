module bst

@[heap]
struct BSTNode[T] {
	data T
mut:
	left  &BSTNode[T] = unsafe { 0 }
	right &BSTNode[T] = unsafe { 0 }
}

fn new_node[T](k T) &BSTNode[T] {
	return &BSTNode[T]{
		data: k
	}
}
