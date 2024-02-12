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

fn (mut q AVLNode[T]) add_child[T](mut p AVLNode[T], left bool) {
	if left {
		q.left = p
	} else {
		q.right = p
	}

	p.parent = q
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
		q.left = p
		if unsafe { q.left != 0 } {
			q.left.parent = p
		}
	} else {
		q.right = p
		if unsafe { q.right != 0 } {
			q.right.parent = p
		}
	}
}
