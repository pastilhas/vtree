module avl

pub fn (mut t AVLTree[T]) min[T]() !&T {
	if unsafe { t.root == 0 } {
		return error('Tree is empty')
	}

	return t.root.min().data
}

fn (p AVLNode[T]) min[T]() &AVLNode[T] {
	mut s := p.left
	if unsafe { s == 0 } {
		return &p
	}

	for unsafe { s.left != 0 } {
		s = s.left
	}

	return s
}
