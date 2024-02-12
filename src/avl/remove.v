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
		if d {
			p = p.left
		} else {
			p = p.right
		}
	}

	if unsafe { p == 0 } {
		return false
	}

	t.size--
	mut q := p.parent
	if unsafe { p.right == 0 } {
		if unsafe { q != 0 } {
			if d {
				q.left = p.left
				if unsafe { q.left != 0 } {
					q.left.parent = q
				}
			} else {
				q.right = p.left
				if unsafe { q.right != 0 } {
					q.right.parent = q
				}
			}
		} else {
			t.root = p.left
		}
	} else {
		mut r := p.right
		if unsafe { r.left == 0 } {
			r.left = p.left
			if unsafe { r.left != 0 } {
				r.left.parent = r
			}

			if unsafe { q != 0 } {
				if d {
					q.left = r
					r.parent = q
				} else {
					q.right = r
					r.parent = q
				}
			} else {
				t.root = r
			}
		} else {
			mut s := r.left
			for unsafe { s.left != 0 } {
				s = s.left
			}
			r = s.parent

			r.left = s.right
			if unsafe { r.left != 0 } {
				r.left.parent = r
			}

			s.left = p.left
			if unsafe { s.left != 0 } {
				s.left.parent = r
			}

			s.right = p.right
			s.right.parent = s

			if unsafe { q != 0 } {
				if d {
					q.left = s
					s.parent = q
				} else {
					q.right = s
					s.parent = q
				}
			} else {
				t.root = s
			}
		}
	}

	return true
}
