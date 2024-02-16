module avl

pub fn (mut t Tree[T]) insert[T](k T) bool {
	if unsafe { t.root == 0 } {
		t.root = t.new_node(k)
		t.size++
		return true
	}

	mut y := t.root
	mut q := t.root
	mut p := t.root
	mut d := false
	for unsafe { p != 0 } {
		cmp := t.cmp(k, t.data(p))
		d = cmp < 0

		if cmp == 0 {
			return false
		}

		if t.bf(p) != 0 {
			y = p
		}

		q = p
		p = t.next(p, d)
	}

	t.size++
	mut n := t.new_node(k)
	t.set_parent(mut n, q, d)

	p = n
	for p != y {
		q = t.parent(p)

		if t.is_left(q, p) {
			t.dec_bf(mut q)
		} else {
			t.inc_bf(mut q)
		}

		p = q
	}

	if t.bf(y) == -2 {
		mut x := t.left(y)
		if t.bf(x) == -1 {
			t.rotate_right(mut y)
			return true
		}

		t.double_rotate_right(mut y)
	} else if t.bf(y) == 2 {
		mut x := t.right(y)
		if t.bf(x) == 1 {
			t.rotate_left(mut y)
			return true
		}

		t.double_rotate_left(mut y)
	}

	assert t.is_valid()
	return true
}
