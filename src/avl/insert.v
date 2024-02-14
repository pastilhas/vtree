module avl

pub fn (mut t Tree[T]) insert[T](k &T) bool {
	if unsafe { t.root == 0 } {
		t.root = new_node(k)
		t.size++
		return true
	}

	mut y := t.root
	mut q := t.root
	mut p := t.root
	mut d := false
	for unsafe { p != 0 } {
		cmp := t.cmp(k, p.data)
		d = cmp < 0

		if cmp == 0 {
			return false
		}

		if p.bf != 0 {
			y = p
		}

		q = p
		p = t.next(p, d)
	}

	t.size++
	mut n := new_node(k)
	t.set_parent(mut n, q, d)

	p = n
	for p != y {
		q = t.parent(p)

		if t.is_left(q, p) {
			q.bf--
		} else {
			q.bf++
		}

		p = q
	}

	t.balance(mut y)
	return true
}

fn (mut t Tree[T]) balance[T](mut y Node[T]) {
	if y.bf == -2 {
		t.balance_left(mut y)
	} else if y.bf == 2 {
		t.balance_right(mut y)
	}
}

fn (mut t Tree[T]) balance_left[T](mut y Node[T]) {
	mut x := t.left(y)
	if x.bf == -1 {
		t.rotate_right(mut y)
	} else {
		t.double_rotate_right(mut y)
	}
}

fn (mut t Tree[T]) balance_right[T](mut y Node[T]) {
	mut x := t.right(y)
	if x.bf == 1 {
		t.rotate_left(mut y)
	} else {
		t.double_rotate_left(mut y)
	}
}
