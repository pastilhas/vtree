module bst

pub fn (mut t BSTree[T]) remove[T](k T) bool {
	assert unsafe { k != 0 }

	if unsafe { t.root == 0 } {
		return false
	}

	mut q := &BSTNode(unsafe { 0 })
	mut p := t.root
	mut cmp := 0
	for unsafe { p != 0 } {
		cmp = t.cmp(k, p.data)

		if cmp == 0 {
			break
		}

		if cmp < 0 {
			q = p
			p = p.left
		} else {
			q = p
			p = p.right
		}
	}

	if unsafe { p == 0 } {
		return false
	}

	t.size--
	if unsafe { p.right == 0 } {
		if unsafe { q != 0 } {
			if cmp < 0 {
				q.left = p.left
			} else {
				q.right = p.left
			}
		} else {
			t.root = p.left
		}
	} else {
		t.replace_right(mut q, p, cmp)
	}

	assert t.is_valid()
	return true
}

fn (mut t BSTree[T]) replace_right[T](mut q BSTNode[T], p BSTNode[T], cmp int) {
	mut r := p.right
	if unsafe { r.left == 0 } {
		r.left = p.left
		if unsafe { p != t.root } {
			if cmp < 0 {
				q.left = r
			} else {
				q.right = r
			}
		} else {
			t.root = r
		}
	} else {
		mut s := r.left
		for unsafe { s.left != 0 } {
			r = s
			s = r.left
		}

		r.left = s.right
		s.left = p.left
		s.right = p.right
		if unsafe { p != t.root } {
			if cmp < 0 {
				q.left = s
			} else {
				q.right = s
			}
		} else {
			t.root = s
		}
	}
}
