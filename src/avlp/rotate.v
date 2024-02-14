module avlp

fn (mut t Tree[T]) rotate_left[T](y int) {
	z := t.parent(y)
	x := t.right(y)

	t.set_parent(x, z, t.is_left(z, y))
	t.set_right(y, t.left(x))
	t.set_left(x, y)

	t.node(x).bf = 0
	t.node(y).bf = 0
}

fn (mut t Tree[T]) double_rotate_left[T](y int) {
	z := t.parent(y)
	x := t.right(y)
	w := t.left(x)

	t.set_parent(w, z, t.is_left(z, y))
	t.set_left(x, t.right(w))
	t.set_right(w, x)
	t.set_right(y, t.left(w))
	t.set_left(w, y)

	if t.bf(w) == 1 {
		t.node(x).bf = 0
		t.node(y).bf = -1
	} else if t.bf(w) == 0 {
		t.node(x).bf = 0
		t.node(y).bf = 0
	} else {
		t.node(x).bf = 1
		t.node(y).bf = 0
	}
	t.node(w).bf = 0
}

fn (mut t Tree[T]) rotate_right[T](y int) {
	z := t.parent(y)
	x := t.left(y)

	t.set_parent(x, z, t.is_left(z, y))
	t.set_left(y, t.right(x))
	t.set_right(x, y)

	t.node(x).bf = 0
	t.node(y).bf = 0
}

fn (mut t Tree[T]) double_rotate_right[T](y int) {
	z := t.parent(y)
	x := t.left(y)
	w := t.right(x)

	t.set_parent(w, z, t.is_left(z, y))
	t.set_right(x, t.left(w))
	t.set_left(w, x)
	t.set_left(y, t.right(w))
	t.set_right(w, y)

	if t.bf(w) == -1 {
		t.node(x).bf = 0
		t.node(y).bf = 1
	} else if t.bf(w) == 0 {
		t.node(x).bf = 0
		t.node(y).bf = 0
	} else {
		t.node(x).bf = -1
		t.node(y).bf = 0
	}
	t.node(w).bf = 0
}
