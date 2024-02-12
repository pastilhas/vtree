module avl

fn compare_f64(a f64, b f64) int {
	return if a < b {
		-1
	} else if a > b {
		1
	} else {
		0
	}
}

fn test_remove_none() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)
	c := f64(2)
	d := f64(1.5)
	e := f64(8)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)

	t.remove(&e)

	assert unsafe { t.root != 0 }
	assert t.root.data == &a
	assert t.size == 4
}

fn test_remove_root() {
	mut t := new[f64](compare_f64)

	a := f64(1)

	t.insert(&a)

	t.remove(&a)

	assert unsafe { t.root == 0 }
	assert t.size == 0
}

fn test_remove_root_with_left() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)

	t.insert(&a)
	t.insert(&b)

	t.remove(&a)

	assert unsafe { t.root != 0 }
	assert t.root.data == &b
	assert t.size == 1
}

fn test_remove_root_with_right() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)
	c := f64(2)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)

	t.remove(&a)

	assert unsafe { t.root != 0 }
	assert t.root.data == &c
	assert t.size == 2
}

fn test_remove_root_with_right_left() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)
	c := f64(2)
	d := f64(1.5)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)

	t.remove(&a)

	assert unsafe { t.root != 0 }
	assert t.root.data == &d
	assert t.size == 3
}

fn test_remove_node() {
	mut t := new[f64](compare_f64)

	a := f64(0)
	b := f64(1)

	t.insert(&a)
	t.insert(&b)

	t.remove(&b)

	assert unsafe { t.root.right == 0 }
	assert t.size == 1
}

fn test_remove_node_with_left() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)
	c := f64(2)
	d := f64(-1)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)

	t.remove(&b)

	assert t.root.left.data == &d
	assert t.size == 3
}

fn test_remove_node_with_right() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)
	c := f64(2)
	d := f64(0.5)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)

	t.remove(&b)

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == &d
	assert t.size == 3
}

fn test_remove_node_with_right_left() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(0)
	c := f64(-1)
	d := f64(2)
	e := f64(1.5)
	f := f64(1.25)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)
	t.insert(&e)
	t.insert(&f)

	t.remove(&c)

	assert t.root.right.data == &e
	assert t.size == 5
}
