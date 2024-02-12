module avl

fn test_insert_one() {
	mut t := new[f64](compare_f64)

	a := f64(1)

	t.insert(&a)

	assert unsafe { t.root != 0 }
	assert t.root.data == &a
	assert t.size == 1
}

fn test_rotate_right() {
	mut t := new[f64](compare_f64)

	a := f64(3)
	b := f64(2)
	c := f64(1)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)

	assert unsafe { t.root != 0 }
	assert t.root.data == &b
	assert t.size == 3

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == &c

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == &a
}

fn test_rotate_left() {
	mut t := new[f64](compare_f64)

	a := f64(1)
	b := f64(2)
	c := f64(3)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)

	assert unsafe { t.root != 0 }
	assert t.root.data == &b
	assert t.size == 3

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == &a

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == &c
}

fn test_double_rotate_left() {
	mut t := new[f64](compare_f64)

	a := f64(2)
	b := f64(1)
	c := f64(6)
	d := f64(4)
	e := f64(7)
	f := f64(3)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)
	t.insert(&e)
	t.insert(&f)

	assert unsafe { t.root != 0 }
	assert t.root.data == &d
	assert t.size == 6

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == &a

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == &c

	assert unsafe { t.root.left.left != 0 }
	assert t.root.left.left.data == &b

	assert unsafe { t.root.left.right != 0 }
	assert t.root.left.right.data == &f

	assert unsafe { t.root.right.right != 0 }
	assert t.root.right.right.data == &e
}

fn test_double_rotate_right() {
	mut t := new[f64](compare_f64)

	a := f64(6)
	b := f64(2)
	c := f64(7)
	d := f64(4)
	e := f64(1)
	f := f64(3)

	t.insert(&a)
	t.insert(&b)
	t.insert(&c)
	t.insert(&d)
	t.insert(&e)
	t.insert(&f)

	assert unsafe { t.root != 0 }
	assert t.root.data == &d
	assert t.size == 6

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == &b

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == &a

	assert unsafe { t.root.left.left != 0 }
	assert t.root.left.left.data == &e

	assert unsafe { t.root.left.right != 0 }
	assert t.root.left.right.data == &f

	assert unsafe { t.root.right.right != 0 }
	assert t.root.right.right.data == &c
}

fn compare_f64(a f64, b f64) int {
	return if a < b {
		-1
	} else if a > b {
		1
	} else {
		0
	}
}
