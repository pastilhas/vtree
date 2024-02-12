module avl

fn (mut t AVLTree[T]) rotate_left[T](mut y AVLNode[T]) {
	mut x := y.right
	mut z := y.parent

	x.parent = z
	if unsafe { z != 0 } {
		if t.cmp(x.data, z.data) < 0 {
			z.left = x
		} else {
			z.right = x
		}
	} else {
		t.root = x
	}

	y.right = x.left
	if unsafe { y.right != 0 } {
		y.right.parent = y
	}

	x.left = y
	y.parent = x

	x.bf = 0
	y.bf = 0
}

fn (mut t AVLTree[T]) double_rotate_left[T](mut y AVLNode[T]) {
	mut z := y.parent
	mut x := y.right
	mut w := x.left

	w.parent = z
	if unsafe { z != 0 } {
		if y == z.left {
			z.left = w
		} else {
			z.right = w
		}
	} else {
		t.root = w
	}

	x.left = w.right
	if unsafe { x.left != 0 } {
		x.left.parent = x
	}

	w.right = x
	x.parent = w

	y.right = w.left
	if unsafe { y.right != 0 } {
		y.right.parent = y
	}

	w.left = y
	y.parent = w

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
}

fn (mut t AVLTree[T]) rotate_right[T](mut y AVLNode[T]) {
	mut x := y.left
	mut z := y.parent

	x.parent = z
	if unsafe { z != 0 } {
		if y == z.left {
			z.left = x
		} else {
			z.right = x
		}
	} else {
		t.root = x
	}

	y.left = x.right
	if unsafe { x.right != 0 } {
		x.right.parent = y
	}

	x.right = y
	y.parent = x

	x.bf = 0
	y.bf = 0
}

fn (mut t AVLTree[T]) double_rotate_right[T](mut y AVLNode[T]) {
	mut z := y.parent
	mut x := y.left
	mut w := x.right

	w.parent = z
	if unsafe { z != 0 } {
		if y == z.left {
			z.left = w
		} else {
			z.right = w
		}
	} else {
		t.root = w
	}

	x.right = w.left
	if unsafe { x.right != 0 } {
		x.right.parent = x
	}

	w.left = x
	x.parent = w

	y.left = w.right
	if unsafe { y.left != 0 } {
		y.left.parent = y
	}

	w.right = y
	y.parent = w

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
}
