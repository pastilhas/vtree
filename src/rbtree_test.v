module vtree

fn test_insert_1() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)

	assert bst.size == 1
	assert bst.is_valid()
}

fn test_insert_2() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)
	bst.insert(55)

	assert bst.size == 1
	assert bst.is_valid()
}

fn test_insert_3() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)
	bst.insert(56)

	assert bst.size == 2
	assert bst.is_valid()
}

fn test_insert_4() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)
	bst.insert(56)
	bst.insert(57)

	assert bst.size == 3
	assert bst.is_valid()
}

fn test_insert_5() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)
	bst.insert(56)
	bst.insert(40)

	assert bst.size == 3
	assert bst.is_valid()
}

fn test_insert_6() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)
	bst.insert(56)
	bst.insert(40)
	bst.insert(30)
	bst.insert(20)
	bst.insert(25)

	assert bst.size == 6
	assert bst.is_valid()
}

fn test_delete_1() {
	mut bst := RBTree.new(cmp)

	bst.insert(55)
	bst.insert(56)
	bst.insert(40)
	bst.insert(30)
	bst.insert(20)
	bst.insert(25)

	assert bst.size == 6
	assert bst.is_valid()

	bst.delete(56)

	assert bst.size == 5
	assert bst.is_valid()
}

fn cmp(a int, b int) int {
	return if a > b {
		1
	} else if a < b {
		-1
	} else {
		0
	}
}

fn (t RBTree[T]) is_valid[T]() bool {
	return t.is_valid_helper(t.root, -2147483648, 2147483647)
}

fn (t RBTree[T]) is_valid_helper[T](n &Node[T], min T, max T) bool {
	return unsafe { n == 0 } || (t.cmp(n.val, min) > 0 && t.cmp(n.val, max) < 0
		&& t.is_valid_helper(n.left, min, n.val) && t.is_valid_helper(n.right, n.val, max))
}
