module avl

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
	t.set_parent(n, q, d)

	p = n
	for p != y {
		q = t.parent(p)

		if t.is_left(q, p) {
			t.dec_bf(q)
		} else {
			t.inc_bf(q)
		}

		p = q
	}

	t.balance(y)
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
	x := t.left(y)
	if t.bf(x) == -1 {
		t.rotate_right(y)
	} else {
		t.double_rotate_right(y)
	}
}

fn (mut t Tree[T]) balance_right[T](y int) {
	x := t.right(y)
	if t.bf(x) == 1 {
		t.rotate_left(y)
	} else {
		t.double_rotate_left(y)
	}
}
