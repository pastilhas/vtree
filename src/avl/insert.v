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
		if cmp < 0 {
			p = p.left
		} else {
			p = p.right
		}
	}

	t.size++
	mut n := new_node(k)
	n.parent = q
	if cmp < 0 {
		q.left = n
	} else {
		q.right = n
	}

	p = n
	for p != y {
		q = p.parent

		if unsafe { q.left != 0 } && q.left == p {
			q.bf--
		} else {
			q.bf++
		}

		p = q
	}

	t.balance(mut y)

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
	mut x := y.left

	if x.bf == -1 {
		t.rotate_right(mut y)
	} else {
		t.double_rotate_right(mut y)
	}
}

fn (mut t AVLTree[T]) balance_right[T](mut y AVLNode[T]) {
	mut x := y.right

	if x.bf == 1 {
		t.rotate_left(mut y)
	} else {
		t.double_rotate_left(mut y)
	}
}
