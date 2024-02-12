module avl

pub fn (t &AVLTree[T]) find[T](k &T) !&T {
	assert unsafe { k != 0 }

	mut p := t.root
	for unsafe { p != 0 } {
		cmp := t.cmp(k, p.data)

		if cmp == 0 {
			return p.data
		}

		p = p.next(cmp < 0)
	}

	return error('item not found')
}

pub fn (t &AVLTree[T]) exists[T](k &T) bool {
	t.find(k) or { return false }
	return true
}
