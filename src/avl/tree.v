module avl

const max_height = 32

struct AVLTree[T] {
mut:
	cmp  fn (T, T) int @[required]
	root &AVLNode[T] = unsafe { 0 }
	size usize
}

pub fn new[T](cmp fn (T, T) int) AVLTree[T] {
	return AVLTree[T]{
		cmp: cmp
	}
}

pub fn (t AVLTree[T]) to_array[T]() []T {
	if unsafe { t.root == 0 } {
		return []T{}
	}
	return t.in_order(t.root)
}

fn (t AVLTree[T]) is_valid[T]() bool {
	return unsafe { t.root == 0 } || t.node_is_valid(t.root)
}

fn (t AVLTree[T]) node_is_valid[T](n &AVLNode[T]) bool {
	return (unsafe { n.left == 0 } || (t.cmp(n.left.data, n.data) < 0 && t.node_is_valid(n.left)))
		&& (unsafe { n.right == 0 } || (t.cmp(n.right.data, n.data) > 0
		&& t.node_is_valid(n.right)))
}

fn (t AVLTree[T]) in_order[T](n &AVLNode[T]) []T {
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

fn (mut t AVLTree[T]) switch_parent[T](p &AVLNode[T], n &AVLNode[T], left bool) {
	mut q := p.parent
	if unsafe { q != 0 } {
		if left {
			q.left = n
			if unsafe { q.left != 0 } {
				q.left.parent = q
			}
		} else {
			q.right = n
			if unsafe { q.right != 0 } {
				q.right.parent = q
			}
		}
	} else {
		t.root = n
	}
}
