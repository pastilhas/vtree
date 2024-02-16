module avl

pub fn (mut t Tree[T]) remove[T](k &T) bool {
	if t.root == -1 {
		return false
	}

	mut p := t.root
	mut d := false

	for p != -1 {
		cmp := t.cmp(k, t.data(p))

		if cmp == 0 {
			break
		}

		d = cmp < 0
		p = t.next(p, d)
	}

	if p == -1 {
		return false
	}

	t.size--
	mut q := t.parent(p)
	if t.right(p) == -1 {
		t.set_parent(t.left(p), q, d)
	} else {
		mut r := t.right(p)
		if t.left(r) == -1 {
			t.set_parent(r, q, d)
			t.set_left(r, t.left(p))
		} else {
			mut s := t.left(r)
			for t.left(s) != -1 {
				s = t.left(s)
			}
			r = t.parent(s)

			t.set_parent(s, q, d)
			t.set_left(r, t.right(s))
			t.set_left(s, t.left(p))
			t.set_right(s, t.right(p))
		}
	}

	return true
}
