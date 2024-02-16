module avl

pub fn (mut t Tree[T]) min[T]() !T {
	if unsafe { t.root == 0 } {
		return error('Tree is empty')
	}

	mut s := t.root
	for unsafe { s.left != 0 } {
		s = s.left
	}

	return t.data(s)
}

pub fn (mut t Tree[T]) max[T]() !T {
	if unsafe { t.root == 0 } {
		return error('Tree is empty')
	}

	mut s := t.root
	for unsafe { s.right != 0 } {
		s = s.right
	}

	return t.data(s)
}
