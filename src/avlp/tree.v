module avlp

struct Node[T] {
	data &T
mut:
	left   int = -1
	right  int = -1
	parent int = -1
	bf     i8
}

struct Tree[T] {
mut:
	size  int
	root  int = -1
	nodes []Node[T]
	cmp   fn (T, T) int @[required]
}

pub fn new[T](cmp fn (T, T) int) Tree[T] {
	return Tree[T]{
		cmp: cmp
	}
}

fn (mut t Tree[T]) new_node[T](k &T) int {
	t.nodes << Node[T]{
		data: unsafe { k }
	}
	return t.nodes.len - 1
}

fn (t Tree[T]) node[T](p int) &Node[T] {
	return &t.nodes[p]
}

fn (t Tree[T]) data[T](p int) &T {
	return t.node(p).data
}

fn (t Tree[T]) is_left[T](q int, p int) bool {
	if q == -1 {
		return false
	}

	return t.node(q).left == p
}

fn (t Tree[T]) left[T](p int) int {
	return t.node(p).left
}

fn (t Tree[T]) right[T](p int) int {
	return t.node(p).right
}

fn (t Tree[T]) parent[T](p int) int {
	return t.node(p).parent
}

fn (t Tree[T]) bf[T](p int) int {
	return t.node(p).bf
}

fn (t Tree[T]) set_left[T](q int, p int) {
	t.node(q).left = p

	if p != -1 {
		t.node(p).parent = q
	}
}

fn (t Tree[T]) set_right[T](q int, p int) {
	t.node(q).right = p

	if p != -1 {
		t.node(p).parent = q
	}
}

fn (t Tree[T]) set_child[T](q int, p int, left bool) {
	t.node(p).parent = q

	if left {
		t.node(q).left = p
	} else {
		t.node(q).right = p
	}
}

fn (mut t Tree[T]) set_parent[T](p int, q int, left bool) {
	t.node(p).parent = q
	if q == -1 {
		t.root = p
		return
	}

	if left {
		t.node(q).left = p
	} else {
		t.node(q).right = p
	}
}

fn (t Tree[T]) next[T](p int, left bool) int {
	return if left {
		t.node(p).left
	} else {
		t.node(p).right
	}
}
