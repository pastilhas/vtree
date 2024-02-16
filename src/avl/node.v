module avl

@[heap]
struct Node[T] {
	data &T
mut:
	left   int = -1
	right  int = -1
	parent int = -1
	bf     i8
}

@[inline]
fn (t Tree[T]) node[T](i int) &Node[T] {
	assert i >= 0 && i < t.nodes.len
	return &t.nodes[i]
}

@[inline]
fn (mut t Tree[T]) new_node[T](k &T) int {
	t.nodes << Node[T]{
		data: unsafe { k }
	}
	return t.nodes.len - 1
}

@[inline]
fn (t Tree[T]) next[T](p int, d bool) int {
	assert p >= 0 && p < t.nodes.len
	return if d {
		t.left(p)
	} else {
		t.right(p)
	}
}

@[inline]
fn (t Tree[T]) is_left[T](q int, p int) bool {
	return q != -1 && t.left(q) == p
}

@[inline]
fn (t Tree[T]) left[T](p int) int {
	assert p >= 0 && p < t.nodes.len
	return t.node(p).left
}

@[inline]
fn (t Tree[T]) right[T](p int) int {
	assert p >= 0 && p < t.nodes.len
	return t.node(p).right
}

@[inline]
fn (t Tree[T]) bf[T](p int) i8 {
	assert p >= 0 && p < t.nodes.len
	return t.node(p).bf
}

@[inline]
fn (t Tree[T]) data[T](p int) &T {
	assert p >= 0 && p < t.nodes.len
	return t.node(p).data
}

@[inline]
fn (t Tree[T]) parent[T](p int) int {
	assert p >= 0 && p < t.nodes.len
	return t.node(p).parent
}

@[inline]
fn (t Tree[T]) set_child[T](q int, p int, d bool) {
	if d {
		t.set_left(q, p)
	} else {
		t.set_right(q, p)
	}
}

@[inline]
fn (t Tree[T]) set_left[T](q int, p int) {
	t.node(q).left = p
	if p != -1 {
		t.node(p).parent = q
	}
}

@[inline]
fn (t Tree[T]) set_right[T](q int, p int) {
	t.node(q).right = p
	if p != -1 {
		t.node(p).parent = q
	}
}

@[inline]
fn (mut t Tree[T]) set_parent[T](p int, q int, d bool) {
	t.node(p).parent = q

	if q == -1 {
		t.root = p
		return
	}

	if d {
		t.node(q).left = p
	} else {
		t.node(q).right = p
	}
}

@[inline]
fn (t Tree[T]) inc_bf[T](p int) {
	t.node(p).bf += 1
}

@[inline]
fn (t Tree[T]) dec_bf[T](p int) {
	t.node(p).bf -= 1
}

@[inline]
fn (t Tree[T]) set_bf[T](p int, i i8) {
	t.node(p).bf = i
}
