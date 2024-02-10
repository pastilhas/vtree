module bst

pub fn (mut t Tree[T]) balance[T]() {
	if unsafe { t.root == 0 } {
		return
	}

	// tree to vine
	mut q := &Node(unsafe { 0 })
	mut p := t.root
	for unsafe { p != 0 } {
		if unsafe { p.right == 0 } {
			q = p
			p = q.left
		} else {
			mut r := p.right
			if unsafe { q != 0 } {
				q.left = r
			} else {
				t.root = r
			}
			p.right = r.left
			r.left = p
			p = r
		}
	}

	assert t.is_valid()

	// vine to tree
	mut l := t.size + 1
	mut next := l & (l - 1)
	for next != 0 {
		l = next
		next = l & (l - 1)
	}
	l = t.size + 1 - l

	t.compress(l)

	mut v := t.size - l
	mut h := 1 + int(l > 0)
	for v > 1 {
		t.compress(v / 2)
		v /= 2
		h++
	}

	assert h <= max_height
	assert t.is_valid()
}

fn (mut t Tree[T]) compress[T](c usize) {
	mut n := t.root
	for i := 0; i < c; i++ {
		mut r := n.left
		mut b := r.left

		n.left = b
		r.left = b.right
		b.right = r
		n = b
	}
}
