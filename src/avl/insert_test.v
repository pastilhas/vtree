module avl

fn test_insert_one() {
	mut t := new[f64](compare_f64)

	t.insert(1)

	assert unsafe { t.root != 0 }
	assert t.root.data == 1
	assert t.size == 1
}

fn test_rotate_right() {
	mut t := new[f64](compare_f64)

	t.insert(3)
	t.insert(2)
	t.insert(1)

	assert unsafe { t.root != 0 }
	assert t.root.data == 2
	assert t.size == 3

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == 1

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == 3
}

fn test_rotate_left() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(2)
	t.insert(3)

	assert unsafe { t.root != 0 }
	assert t.root.data == 2
	assert t.size == 3

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == 1

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == 3
}

fn test_double_rotate_left() {
	mut t := new[f64](compare_f64)

	t.insert(2)
	t.insert(1)
	t.insert(6)
	t.insert(4)
	t.insert(7)
	t.insert(3)

	assert unsafe { t.root != 0 }
	assert t.root.data == 4
	assert t.size == 6

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == 2

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == 6

	assert unsafe { t.root.left.left != 0 }
	assert t.root.left.left.data == 1

	assert unsafe { t.root.left.right != 0 }
	assert t.root.left.right.data == 3

	assert unsafe { t.root.right.right != 0 }
	assert t.root.right.right.data == 7
}

fn test_double_rotate_right() {
	mut t := new[f64](compare_f64)

	t.insert(6)
	t.insert(2)
	t.insert(7)
	t.insert(4)
	t.insert(1)
	t.insert(3)

	assert unsafe { t.root != 0 }
	assert t.root.data == 4
	assert t.size == 6

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == 2

	assert unsafe { t.root.right != 0 }
	assert t.root.right.data == 6

	assert unsafe { t.root.left.left != 0 }
	assert t.root.left.left.data == 1

	assert unsafe { t.root.left.right != 0 }
	assert t.root.left.right.data == 3

	assert unsafe { t.root.right.right != 0 }
	assert t.root.right.right.data == 7
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
