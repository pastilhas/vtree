module bst

pub fn (t &Tree[T]) find[T](k &T) ?&T {
	assert unsafe { k != 0 }

	mut p := t.root
	for unsafe { p != 0 } {
		cmp := t.cmp(k, p.data)

		if cmp == 0 {
			return p.data
		}

		if cmp < 0 {
			p = p.left
		} else {
			p = p.right
		}
	}

	return none
}

pub fn (t &Tree[T]) exists[T](k &T) bool {
	t.find(k) or { return false }
	return true
}
