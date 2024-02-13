module bst

struct BSTree[T] {
mut:
	cmp  fn (T, T) int @[required]
	root &BSTNode[T] = unsafe { 0 }
	size usize
}

pub fn new[T](cmp fn (T, T) int) BSTree[T] {
	return BSTree[T]{
		cmp: cmp
	}
}

pub fn (t BSTree[T]) to_array[T]() []T {
	return t.in_order(t.root)
}

fn (t BSTree[T]) is_valid() bool {
	return unsafe { t.root == 0 } || t.node_is_valid(t.root)
}

fn (t BSTree[T]) node_is_valid[T](n &BSTNode[T]) bool {
	return (unsafe { n.left == 0 } || (t.cmp(n.left.data, n.data) < 0 && t.node_is_valid(n.left)))
		&& (unsafe { n.right == 0 } || (t.cmp(n.right.data, n.data) > 0
		&& t.node_is_valid(n.right)))
}

fn (t BSTree[T]) in_order[T](n &BSTNode[T]) []T {
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
