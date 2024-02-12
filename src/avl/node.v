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

fn (q AVLNode[T]) next[T](left bool) &AVLNode[T] {
	return if left {
		q.left
	} else {
		q.right
	}
}

fn (q AVLNode[T]) is_left[T](p &AVLNode[T]) bool {
	return unsafe { q.left != 0 } && q.left == p
}

fn (mut q AVLNode[T]) set_child[T](p &AVLNode[T], left bool) {
	if left {
		q.set_left(p)
	} else {
		q.set_right(p)
	}
}

fn (mut q AVLNode[T]) set_left[T](p &AVLNode[T]) {
	q.left = p
	if unsafe { q.left != 0 } {
		q.left.parent = q
	}
}

fn (mut q AVLNode[T]) set_right[T](p &AVLNode[T]) {
	q.right = p
	if unsafe { q.right != 0 } {
		q.right.parent = q
	}
}
