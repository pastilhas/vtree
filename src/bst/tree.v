module bst

const max_height = 32

struct Tree[T] {
mut:
	cmp  fn (T, T) int @[required]
	root &Node[T] = unsafe { 0 }
	size usize
}

pub fn new[T](cmp fn (T, T) int) Tree[T] {
	return Tree[T]{
		cmp: cmp
	}
}

pub fn (t Tree[T]) to_array[T]() []T {
	return t.in_order(t.root)
}

fn set_child[T](mut p Node[T], q &Node[T], right int) {
	if right > 0 {
		p.right = q
	} else {
		p.left = q
	}
}

fn (t Tree[T]) is_valid() bool {
	return unsafe { t.root == 0 } || t.node_is_valid(t.root)
}

fn (t Tree[T]) node_is_valid[T](n &Node[T]) bool {
	return (unsafe { n.left == 0 } || (t.cmp(n.left.data, n.data) < 0 && t.node_is_valid(n.left)))
		&& (unsafe { n.right == 0 } || (t.cmp(n.right.data, n.data) > 0
		&& t.node_is_valid(n.right)))
}

fn (t Tree[T]) in_order[T](n &Node[T]) []T {
	mut res := []T{}

	if unsafe { n.left != 0 } {
		res << t.in_order(n.left)
	}

	res << *n.data

	if unsafe { n.right != 0 } {
		res << t.in_order(n.right)
	}

	return res
}
