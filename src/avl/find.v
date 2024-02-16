module avl

pub fn (t &Tree[T]) find[T](k T) !T {
	if unsafe { t.root == 0 } {
		return error('Tree is empty')
	}

	mut p := t.root
	for unsafe { p != 0 } {
		cmp := t.cmp(k, t.data(p))

		if cmp == 0 {
			return t.data(p)
		}

		p = t.next(p, cmp < 0)
	}

	return error('Item not found')
}

pub fn (t &Tree[T]) exists[T](k T) bool {
	t.find(k) or { return false }
	return true
}
