module avl

fn (mut t Tree[T]) rotate_left[T](mut y Node[T]) {
	mut x := t.right(y)
	mut z := t.parent(y)

	t.set_parent(mut x, z, t.is_left(z, y))
	t.set_right(mut y, t.left(x))
	t.set_left(mut x, y)

	t.set_bf(mut x, 0)
	t.set_bf(mut y, 0)
}

fn (mut t Tree[T]) double_rotate_left[T](mut y Node[T]) {
	mut z := t.parent(y)
	mut x := t.right(y)
	mut w := t.left(x)

	t.set_parent(mut w, z, t.is_left(z, y))
	t.set_left(mut x, t.right(w))
	t.set_right(mut w, x)
	t.set_right(mut y, t.left(w))
	t.set_left(mut w, y)

	if t.bf(w) == 1 {
		t.set_bf(mut x, 0)
		t.set_bf(mut y, -1)
	} else if t.bf(w) == 0 {
		t.set_bf(mut x, 0)
		t.set_bf(mut y, 0)
	} else {
		t.set_bf(mut x, 1)
		t.set_bf(mut y, 0)
	}
	t.set_bf(mut w, 0)
}

fn (mut t Tree[T]) rotate_right[T](mut y Node[T]) {
	mut x := t.left(y)
	mut z := t.parent(y)

	t.set_parent(mut x, z, t.is_left(z, y))
	t.set_left(mut y, t.right(x))
	t.set_right(mut x, y)

	t.set_bf(mut x, 0)
	t.set_bf(mut y, 0)
}

fn (mut t Tree[T]) double_rotate_right[T](mut y Node[T]) {
	mut z := t.parent(y)
	mut x := t.left(y)
	mut w := t.right(x)

	t.set_parent(mut w, z, t.is_left(z, y))
	t.set_right(mut x, t.left(w))
	t.set_left(mut w, x)
	t.set_left(mut y, t.right(w))
	t.set_right(mut w, y)

	if t.bf(w) == -1 {
		t.set_bf(mut x, 0)
		t.set_bf(mut y, 1)
	} else if t.bf(w) == 0 {
		t.set_bf(mut x, 0)
		t.set_bf(mut y, 0)
	} else {
		t.set_bf(mut x, -1)
		t.set_bf(mut y, 0)
	}
	t.set_bf(mut w, 0)
}
