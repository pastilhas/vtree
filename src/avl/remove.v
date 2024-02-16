module avl

pub fn (mut t Tree[T]) remove[T](k &T) bool {
	if unsafe { t.root == 0 } {
		return false
	}

	mut p := t.root
	mut d := false

	for unsafe { p != 0 } {
		cmp := t.cmp(k, p.data)

		if cmp == 0 {
			break
		}

		d = cmp < 0
		p = t.next(p, d)
	}

	if unsafe { p == 0 } {
		return false
	}

	t.size--
	mut q := t.parent(p)
	if unsafe { t.right(p) == 0 } {
		t.set_parent(mut t.left(p), q, d)
	} else {
		mut r := t.right(p)
		if unsafe { t.left(r) == 0 } {
			t.set_parent(mut r, q, d)
			t.set_left(mut r, t.left(p))
		} else {
			mut s := t.left(r)
			for unsafe { t.left(s) != 0 } {
				s = t.left(s)
			}
			r = t.parent(s)

			t.set_parent(mut s, q, d)
			t.set_left(mut r, t.right(s))
			t.set_left(mut s, t.left(p))
			t.set_right(mut s, t.right(p))
		}
	}

	assert t.is_valid()
	return true
}
