module avl

pub fn (mut t AVLTree[T]) insert[T](k &T) bool {
	assert unsafe { k != 0 }

	if unsafe { t.root == 0 } {
		t.root = new_node(k)
		t.size++
		return true
	}

	mut y := t.root
	mut q := t.root
	mut p := t.root
	mut cmp := 0

	for unsafe { p != 0 } {
		cmp = t.cmp(k, p.data)

		if cmp == 0 {
			return false
		}

		if p.bf != 0 {
			y = p
		}

		q = p
		p = p.next(cmp < 0)
	}

	t.size++
	n := new_node(k)
	q.set_child(n, cmp < 0)

	p = n
	for p != y {
		q = p.parent

		if q.is_left(p) {
			q.bf--
		} else {
			q.bf++
		}

		p = q
	}

	t.balance(mut y)

	assert t.is_valid()
	return true
}

fn (mut t AVLTree[T]) balance[T](mut y AVLNode[T]) {
	if y.bf == -2 {
		t.balance_left(mut y)
	} else if y.bf == 2 {
		t.balance_right(mut y)
	}
}

fn (mut t AVLTree[T]) balance_left[T](mut y AVLNode[T]) {
	if y.left.bf == -1 {
		t.rotate_right(mut y)
		return
	}

	t.double_rotate_right(mut y)
}

fn (mut t AVLTree[T]) balance_right[T](mut y AVLNode[T]) {
	if y.right.bf == 1 {
		t.rotate_left(mut y)
		return
	}

	t.double_rotate_left(mut y)
}
