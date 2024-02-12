module pavl

const max_height = 32

struct PAVLTree[T] {
mut:
	cmp  fn (T, T) int @[required]
	root &PAVLNode[T] = unsafe { 0 }
	size usize
}

pub fn new[T](cmp fn (T, T) int) PAVLTree[T] {
	return PAVLTree[T]{
		cmp: cmp
	}
}

pub fn (t PAVLTree[T]) to_array[T]() []T {
	return t.in_order(t.root)
}

fn (t PAVLTree[T]) is_valid[T]() bool {
	return unsafe { t.root == 0 } || t.node_is_valid(t.root)
}

fn (t PAVLTree[T]) node_is_valid[T](n &PAVLNode[T]) bool {
	return (unsafe { n.left == 0 } || (t.cmp(n.left.data, n.data) < 0 && t.node_is_valid(n.left)))
		&& (unsafe { n.right == 0 } || (t.cmp(n.right.data, n.data) > 0
		&& t.node_is_valid(n.right)))
}

fn (t PAVLTree[T]) in_order[T](n &PAVLNode[T]) []T {
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
