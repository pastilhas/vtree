module avl

pub fn (mut t AVLTree[T]) remove[T](k &T) bool {
	assert unsafe { k != 0 }

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
		p = p.next(d)
	}

	if unsafe { p == 0 } {
		return false
	}

	t.size--
	if unsafe { p.right == 0 } {
		t.switch_parent(p, p.left)
	} else {
		mut r := p.right
		if unsafe { r.left == 0 } {
			r.set_left(p.left)
			t.switch_parent(p, r)
		} else {
			mut s := r.min()
			r = s.parent

			r.set_left(s.right)
			s.set_left(p.left)
			s.set_right(p.right)
			t.switch_parent(p, s)
		}
	}

	assert t.is_valid()
	return true
}
