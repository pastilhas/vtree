module avlp

pub fn (mut t Tree[T]) insert[T](k &T) bool {
	if t.root == -1 {
		t.root = t.new_node(k)
		t.size++
		return true
	}

	mut y := t.root
	mut q := t.root
	mut p := t.root
	mut d := false

	for p != -1 {
		cmp := t.cmp(k, t.data(p))
		if cmp == 0 {
			return false
		}

		if t.node(p).bf != 0 {
			y = p
		}

		d = cmp < 0
		q = p
		p = t.next(p, d)
	}

	t.size++
	n := t.new_node(k)
	t.set_parent(n, q, d)

	p = n
	for p != y {
		q = t.parent(p)

		if q == -1 {
			break
		}

		if t.is_left(q, p) {
			t.node(q).bf -= 1
		} else {
			t.node(q).bf += 1
		}

		p = q
	}

	t.balance(y)

	// assert t.is_valid()
	return true
}

fn (mut t Tree[T]) balance[T](y int) {
	if t.bf(y) == -2 {
		t.balance_left(y)
	} else if t.bf(y) == 2 {
		t.balance_right(y)
	}
}

fn (mut t Tree[T]) balance_left[T](y int) {
	if t.bf(t.left(y)) == -1 {
		t.rotate_right(y)
		return
	}

	t.double_rotate_right(y)
}

fn (mut t Tree[T]) balance_right[T](y int) {
	if t.bf(t.right(y)) == 1 {
		t.rotate_left(y)
		return
	}

	t.double_rotate_left(y)
}
