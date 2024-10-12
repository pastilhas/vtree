module vtree

import rand

fn test_insert_basic() {
	mut tree := RBTree.new(cmp)
	assert tree.insert(10)
	assert tree.size == 1
	assert tree.is_valid()
	assert !tree.insert(10) // Duplicate insertion
	assert tree.size == 1
}

fn test_insert_multiple() {
	mut tree := RBTree.new(cmp)
	numbers := [50, 30, 70, 20, 40, 60, 80]
	for num in numbers {
		assert tree.insert(num)
	}
	assert tree.size == numbers.len
	assert tree.is_valid()
}

fn test_insert_ascending() {
	mut tree := RBTree.new(cmp)
	for i in 1 .. 101 {
		assert tree.insert(i)
	}
	assert tree.size == 100
	assert tree.is_valid()
}

fn test_insert_descending() {
	mut tree := RBTree.new(cmp)
	for i := 100; i > 0; i-- {
		assert tree.insert(i)
	}
	assert tree.size == 100
	assert tree.is_valid()
}

fn test_delete_basic() {
	mut tree := RBTree.new(cmp)
	tree.insert(10)
	assert tree.delete(10)
	assert tree.size == 0
	assert tree.is_valid()
	assert !tree.delete(10) // Deleting non-existent element
}

fn test_delete_root() {
	mut tree := RBTree.new(cmp)
	tree.insert(50)
	tree.insert(30)
	tree.insert(70)
	assert tree.delete(50)
	assert tree.size == 2
	assert tree.is_valid()
}

fn test_delete_leaf() {
	mut tree := RBTree.new(cmp)
	tree.insert(50)
	tree.insert(30)
	tree.insert(70)
	assert tree.delete(30)
	assert tree.size == 2
	assert tree.is_valid()
}

fn test_delete_with_one_child() {
	mut tree := RBTree.new(cmp)
	tree.insert(50)
	tree.insert(30)
	tree.insert(70)
	tree.insert(20)
	assert tree.delete(30)
	assert tree.size == 3
	assert tree.is_valid()
}

fn test_delete_with_two_children() {
	mut tree := RBTree.new(cmp)
	tree.insert(50)
	tree.insert(30)
	tree.insert(70)
	tree.insert(20)
	tree.insert(40)
	assert tree.delete(30)
	assert tree.size == 4
	assert tree.is_valid()
}

fn test_delete_multiple() {
	mut tree := RBTree.new(cmp)
	numbers := [50, 30, 70, 20, 40, 60, 80]
	for num in numbers {
		tree.insert(num)
	}
	for num in numbers {
		assert tree.delete(num)
		assert tree.is_valid()
	}
	assert tree.size == 0
}

fn test_find() {
	mut tree := RBTree.new(cmp)
	numbers := [50, 30, 70, 20, 40, 60, 80]
	for num in numbers {
		tree.insert(num)
	}
	for num in numbers {
		found := tree.find(num) or { panic('Value not found') }
		assert found == num
	}
	tree.find(100) or { assert true }
}

fn test_inorder() {
	mut tree := RBTree.new(cmp)
	numbers := [50, 30, 70, 20, 40, 60, 80]
	for num in numbers {
		tree.insert(num)
	}
	inorder := tree.inorder()
	assert inorder == [20, 30, 40, 50, 60, 70, 80]
}

fn test_large_tree() {
	mut tree := RBTree.new(cmp)
	for i in 1 .. 1001 {
		assert tree.insert(i)
	}
	assert tree.size == 1000
	assert tree.is_valid()
	for i in 1 .. 1001 {
		assert tree.delete(i)
		assert tree.is_valid()
	}
	assert tree.size == 0
}

/*
fn test_random_operations() {
	mut tree := RBTree.new(cmp)
	for _ in 0 .. 1000 {
		operation := rand.int_in_range(0, 2)!
		value := rand.int_in_range(1, 1001)!
		match operation {
			0 { tree.insert(value) }
			1 { tree.delete(value) }
			else {}
		}
		assert tree.is_valid()
	}
}
*/
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
