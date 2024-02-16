module avl

@[heap]
struct Node[T] {
	data T
mut:
	left   &Node[T] = unsafe { 0 }
	right  &Node[T] = unsafe { 0 }
	parent &Node[T] = unsafe { 0 }
	bf     i8
}

@[inline]
fn (t Tree[T]) new_node[T](k T) &Node[T] {
	return &Node[T]{
		data: unsafe { k }
	}
}

@[inline]
fn (t Tree[T]) next[T](p &Node[T], d bool) &Node[T] {
	assert unsafe { p != 0 }
	return if d {
		t.left(p)
	} else {
		t.right(p)
	}
}

@[inline]
fn (t Tree[T]) is_left[T](q &Node[T], p &Node[T]) bool {
	return unsafe { q != 0 && t.left(q) != 0 } && t.left(q) == p
}

@[inline]
fn (t Tree[T]) left[T](p &Node[T]) &Node[T] {
	assert unsafe { p != 0 }
	return p.left
}

@[inline]
fn (t Tree[T]) right[T](p &Node[T]) &Node[T] {
	assert unsafe { p != 0 }
	return p.right
}

@[inline]
fn (t Tree[T]) bf[T](p &Node[T]) i8 {
	assert unsafe { p != 0 }
	return p.bf
}

@[inline]
fn (t Tree[T]) parent[T](p &Node[T]) &Node[T] {
	assert unsafe { p != 0 }
	return p.parent
}

@[inline]
fn (t Tree[T]) set_child[T](mut q Node[T], p &Node[T], d bool) {
	if d {
		t.set_left(mut q, p)
	} else {
		t.set_right(mut q, p)
	}
}

@[inline]
fn (t Tree[T]) set_left[T](mut q Node[T], p &Node[T]) {
	q.left = p
	if unsafe { p != 0 } {
		q.left.parent = q
	}
}

@[inline]
fn (t Tree[T]) set_right[T](mut q Node[T], p &Node[T]) {
	q.right = p
	if unsafe { p != 0 } {
		q.right.parent = q
	}
}

@[inline]
fn (mut t Tree[T]) set_parent[T](mut p Node[T], q &Node[T], d bool) {
	p.parent = q
	if unsafe { q == 0 } {
		t.root = p
		return
	}

	if d {
		t.parent(p).left = p
	} else {
		t.parent(p).right = p
	}
}

@[inline]
fn (t Tree[T]) inc_bf[T](mut p Node[T]) {
	p.bf += 1
}

@[inline]
fn (t Tree[T]) dec_bf[T](mut p Node[T]) {
	p.bf -= 1
}

@[inline]
fn (t Tree[T]) set_bf[T](mut p Node[T], i i8) {
	p.bf = i
}
