module avl

const max_height = 32

struct Tree[T] {
mut:
	cmp   fn (T, T) int @[required]
	nodes []Node[T]
	root  int = -1
	size  usize
}

pub fn new[T](cmp fn (T, T) int) Tree[T] {
	return Tree[T]{
		cmp: cmp
	}
}

/*
pub fn (t Tree[T]) to_array[T]() []T {
	if t.root == -1 {
		return []T{}
	}
	return t.in_order(t.root)
}

fn (t Tree[T]) is_valid[T]() bool {
	return t.root == -1 || t.node_is_valid(t.root)
}

fn (t Tree[T]) node_is_valid[T](n int) bool {
	// l := n.left == -1 || (t.cmp(n.left.data, n.data) < 0 && t.node_is_valid(n.left))
	// r := n.right == -1 || (t.cmp(n.right.data, n.data) < 0 && t.node_is_valid(n.right))

	return true
}

fn (t Tree[T]) in_order[T](n &Node[T]) []T {
	mut res := []T{}

	if n.left != -1 {
		res << t.in_order(n.left)
	}

	res << *n.data

	if n.right != -1 {
		res << t.in_order(n.right)
	}

	return res
}
*/
