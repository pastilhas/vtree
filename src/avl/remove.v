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
		t.switch_parent(p, p.left, d)
	} else {
		mut r := p.right
		if unsafe { r.left == 0 } {
			r.set_child(p.left, true)
			t.switch_parent(p, r, d)
		} else {
			mut s := r.left
			for unsafe { s.left != 0 } {
				s = s.left
			}
			r = s.parent

			r.set_child(s.right, true)
			s.set_child(p.left, true)
			s.set_child(p.right, false)
			t.switch_parent(p, s, d)
		}
	}

	return true
}
