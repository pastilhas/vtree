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

	t.insert(1)
	t.insert(0)
	t.insert(2)
	t.insert(1.5)

	t.remove(8)

	assert unsafe { t.root != 0 }
	assert t.root.data == 1
	assert t.size == 4
}

fn test_remove_root() {
	mut t := new[f64](compare_f64)

	t.insert(1)

	t.remove(1)

	assert unsafe { t.root == 0 }
	assert t.size == 0
}

fn test_remove_root_with_left() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(0)

	t.remove(1)

	assert unsafe { t.root != 0 }
	assert t.root.data == 0
	assert t.size == 1
}

fn test_remove_root_with_right() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(0)
	t.insert(2)

	t.remove(1)

	assert unsafe { t.root != 0 }
	assert t.root.data == 2
	assert t.size == 2
}

fn test_remove_root_with_right_left() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(0)
	t.insert(2)
	t.insert(1.5)

	t.remove(1)

	assert unsafe { t.root != 0 }
	assert t.root.data == 1.5
	assert t.size == 3
}

fn test_remove_node() {
	mut t := new[f64](compare_f64)

	t.insert(0)
	t.insert(1)

	t.remove(1)

	assert unsafe { t.root.right == 0 }
	assert t.size == 1
}

fn test_remove_node_with_left() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(0)
	t.insert(2)
	t.insert(-1)

	t.remove(0)

	assert t.root.left.data == -1
	assert t.size == 3
}

fn test_remove_node_with_right() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(0)
	t.insert(2)
	t.insert(0.5)

	t.remove(0)

	assert unsafe { t.root.left != 0 }
	assert t.root.left.data == 0.5
	assert t.size == 3
}

fn test_remove_node_with_right_left() {
	mut t := new[f64](compare_f64)

	t.insert(1)
	t.insert(0)
	t.insert(-1)
	t.insert(2)
	t.insert(1.5)
	t.insert(1.25)

	t.remove(-1)

	assert t.root.right.data == 1.5
	assert t.size == 5
}
