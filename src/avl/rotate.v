module avl

fn (mut t AVLTree[T]) rotate_left[T](mut y AVLNode[T]) {
	mut x := y.right

	t.switch_parent(y, x)
	y.set_right(x.left)
	x.set_left(y)

	x.bf = 0
	y.bf = 0
}

fn (mut t AVLTree[T]) double_rotate_left[T](mut y AVLNode[T]) {
	mut x := y.right
	mut w := x.left

	t.switch_parent(y, w)
	x.set_left(w.right)
	w.set_right(x)
	y.set_right(w.left)
	w.set_left(y)

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

	t.switch_parent(y, x)
	y.set_left(x.right)
	x.set_right(y)

	x.bf = 0
	y.bf = 0
}

fn (mut t AVLTree[T]) double_rotate_right[T](mut y AVLNode[T]) {
	mut x := y.left
	mut w := x.right

	t.switch_parent(y, w)
	x.set_right(w.left)
	w.set_left(x)
	y.set_left(w.right)
	w.set_right(y)

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
