module avl

pub fn (mut t AVLTree[T]) insert[T](k &T) bool {
	assert unsafe { k != 0 }

	if unsafe { t.root == 0 } {
		t.root = new_node(k)
		t.size++
		return true
	}

	mut z := t.root
	mut y := t.root
	mut q := z
	mut p := y
	mut s := []bool{cap: max_height}
	mut cmp := 0

	for unsafe { p != 0 } {
		cmp = t.cmp(k, p.data)

		if cmp == 0 {
			return false
		}

		if p.bf != 0 {
			z = q
			y = p
			s.clear()
		}

		s << (cmp < 0)
		q = p
		if cmp < 0 {
			p = p.left
		} else {
			p = p.right
		}
	}

	t.size++
	mut n := new_node(k)
	if cmp < 0 {
		q.left = n
	} else {
		q.right = n
	}

	p = y
	for a := 0; p != n; a++ {
		if s[a] {
			p.bf--
		} else {
			p.bf++
		}

		if s[a] {
			p = p.left
		} else {
			p = p.right
		}
	}

	t.balance(mut z, mut y)

	assert t.is_valid()
	return true
}

pub fn (mut t AVLTree[T]) balance[T](mut z AVLNode[T], mut y AVLNode[T]) {
	w := if y.bf == -2 {
		t.balance_left(mut y)
	} else if y.bf == 2 {
		t.balance_right(mut y)
	} else {
		return
	}

	if y == t.root {
		t.root = w
		return
	}

	if z.left == y {
		z.left = w
	} else {
		z.right = w
	}
}

pub fn (mut t AVLTree[T]) balance_left[T](mut y AVLNode[T]) &AVLNode[T] {
	mut x := y.left

	if x.bf == -1 {
		y.left = x.right
		x.right = y
		x.bf = 0
		y.bf = 0

		return x
	}

	mut w := x.right
	x.right = w.left
	w.left = x
	y.left = w.right
	w.right = y

	if w.bf == -1 {
		x.bf = 0
		y.bf = 1
	} else if w.bf == 0 {
		x.bf = 0
		y.bf = 0
	} else {
		x.bf = -1
		y.bf = 0
	}

	w.bf = 0

	return w
}

pub fn (mut t AVLTree[T]) balance_right[T](mut y AVLNode[T]) &AVLNode[T] {
	mut x := y.right

	if x.bf == 1 {
		y.right = x.left
		x.left = y
		x.bf = 0
		y.bf = 0

		return x
	}

	mut w := x.left
	x.left = w.right
	w.right = x
	y.right = w.left
	w.left = y

	if w.bf == 1 {
		x.bf = 0
		y.bf = -1
	} else if w.bf == 0 {
		x.bf = 0
		y.bf = 0
	} else {
		x.bf = 1
		y.bf = 0
	}

	w.bf = 0

	return w
}
