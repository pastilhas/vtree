module bst

pub fn (mut t BSTree[T]) insert[T](k &T) bool {
	assert unsafe { k != 0 }

	if unsafe { t.root == 0 } {
		t.root = new_node(k)
		t.size++
		return true
	}

	mut q := t.root
	for p := t.root; unsafe { p != 0 }; {
		cmp := t.cmp(k, p.data)

		if cmp == 0 {
			return false
		}

		q = p
		if cmp < 0 {
			p = p.left
		} else {
			p = p.right
		}
	}

	t.size++
	n := new_node(k)
	if t.cmp(k, q.data) < 0 {
		q.left = n
	} else {
		q.right = n
	}

	assert t.is_valid()
	return true
}
