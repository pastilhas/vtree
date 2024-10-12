module vtree

const red = true
const black = false

@[heap]
struct Node[T] {
	val T
mut:
	color  bool
	left   &Node[T] = unsafe { 0 }
	right  &Node[T] = unsafe { 0 }
	parent &Node[T] = unsafe { 0 }
}

struct RBTree[T] {
	cmp fn (T, T) int @[required]
mut:
	root &Node[T] = unsafe { 0 }
	size int
}

fn Node.new[T](value T) &Node[T] {
	return &Node[T]{
		val:   value
		color: red
	}
}

fn RBTree.new[T](compare fn (T, T) int) &RBTree[T] {
	return &RBTree[T]{
		cmp: compare
	}
}

fn (mut t RBTree[T]) inorder[T]() []T {
	mut res := []T{cap: t.size}
	t.inorder_helper(t.root, mut res)
	return res
}

fn (mut t RBTree[T]) inorder_helper[T](node &Node[T], mut res []T) {
	if unsafe { node == 0 } {
		return
	}

	t.inorder_helper(node.left, mut res)
	res << node.val
	t.inorder_helper(node.right, mut res)
}

fn (mut t RBTree[T]) insert[T](val T) bool {
	mut node := Node.new(val)
	if unsafe { t.root == 0 } {
		t.root = node
		t.size += 1
		return true
	}
	mut q := t.root
	for p := t.root; unsafe { p != 0 }; {
		c := t.cmp(p.val, val)
		if c == 0 {
			return false
		}
		q = p
		p = if c > 0 {
			p.left
		} else {
			p.right
		}
	}
	t.size += 1
	node.parent = q
	if t.cmp(q.val, val) > 0 {
		q.left = node
	} else {
		q.right = node
	}
	t.insert_fix(node)
	return true
}

fn (mut t RBTree[T]) insert_fix[T](node &Node[T]) {
	mut n := &unsafe { *node }
	for unsafe { n.parent != 0 } && n.parent.color == red {
		mut gp := n.parent.parent
		if unsafe { gp == 0 } {
			break
		}
		if unsafe { gp.right != 0 } && n.parent == gp.right {
			mut u := gp.left
			if unsafe { u != 0 } && u.color == red {
				u.color = black
				n.parent.color = black
				gp.color = red
				n = gp
			} else {
				if unsafe { n.parent.left != 0 } && n == n.parent.left {
					n = n.parent
					t.rotate_right(n)
				}
				n.parent.color = black
				n.parent.parent.color = red
				t.rotate_left(n.parent.parent)
			}
		} else {
			mut u := gp.right
			if unsafe { u != 0 } && u.color == red {
				u.color = black
				n.parent.color = black
				gp.color = red
				n = gp
			} else {
				if unsafe { n.parent.right != 0 } && n == n.parent.right {
					n = n.parent
					t.rotate_left(n)
				}
				n.parent.color = black
				n.parent.parent.color = red
				t.rotate_right(n.parent.parent)
			}
		}
	}
	t.root.color = black
}

fn (mut t RBTree[T]) delete[T](val T) bool {
	if t.size == 0 {
		return false
	}
	mut node := t.root.parent
	for p := t.root; unsafe { p != 0 }; {
		c := t.cmp(p.val, val)
		if c == 0 {
			node = p
			break
		}
		p = if c > 0 {
			p.left
		} else {
			p.right
		}
	}
	if unsafe { node == 0 } {
		return false
	}
	t.size -= 1
	mut node3 := node
	mut node2 := node
	mut og_color := node2.color
	if unsafe { node.left == 0 } {
		node3 = node.right
		t.transplant(node, node.right)
	} else if unsafe { node.right == 0 } {
		node3 = node.left
		t.transplant(node, node.left)
	} else {
		node2 = t.min(node.right)
		og_color = node2.color
		node3 = node2.right
		if node2.parent == node {
			node3.parent = node2
		} else {
			t.transplant(node2, node2.right)
			node2.right = node.right
			node2.right.parent = node2
		}

		t.transplant(node, node2)
		node2.left = node.left
		node2.left.parent = node2
		node2.color = node.color
	}
	if unsafe { node3 != 0 } && og_color == black {
		t.delete_fix(node3)
	}
	return true
}

fn (mut t RBTree[T]) delete_fix[T](node &Node[T]) {
	mut n := &unsafe { *node }
	for n != t.root && n.color == black {
		if unsafe { n.parent != 0 } && n == n.parent.left {
			mut s := n.parent.right
			if s.color == red {
				s.color = black
				n.parent.color = red
				t.rotate_left(n.parent)
				s = n.parent.right
			}
			if s.left.color == black && s.right.color == black {
				s.color = red
				n = n.parent
			} else {
				if s.right.color == black {
					s.left.color = black
					s.color = red
					t.rotate_right(s)
					s = n.parent.right
				}

				s.color = n.parent.color
				n.parent.color = black
				s.right.color = black
				t.rotate_left(n.parent)
				n = t.root
			}
		} else {
			mut s := n.parent.left
			if s.color == red {
				s.color = black
				n.parent.color = red
				t.rotate_right(n.parent)
				s = n.parent.left
			}

			if s.right.color == black && s.left.color == black {
				s.color = red
				n = n.parent
			} else {
				if s.left.color == black {
					s.right.color = black
					s.color = red
					t.rotate_left(s)
					s = n.parent.left
				}

				s.color = n.parent.color
				n.parent.color = black
				s.left.color = black
				t.rotate_right(n.parent)
				n = t.root
			}
		}
	}
	n.color = black
}

fn (mut t RBTree[T]) transplant[T](n1 &Node[T], n2 &Node[T]) {
	mut u := unsafe { n1 }
	mut v := unsafe { n2 }
	if unsafe { u.parent == 0 } {
		t.root = v
	} else if u == u.parent.left {
		u.parent.left = v
	} else {
		u.parent.right = v
	}
	if unsafe { v != 0 } {
		v.parent = u.parent
	}
}

fn (mut t RBTree[T]) find[T](val T) ?T {
	for p := t.root; unsafe { p != 0 }; {
		c := t.cmp(p.val, val)
		if c == 0 {
			return p.val
		}
		p = if c > 0 {
			p.left
		} else {
			p.right
		}
	}
	return none
}

fn (mut t RBTree[T]) rotate_left[T](node &Node[T]) {
	mut n := &unsafe { *node }
	mut r := node.right
	n.right = r.left
	if unsafe { r.left != 0 } {
		r.left.parent = n
	}
	r.parent = n.parent
	if unsafe { n.parent == 0 } {
		t.root = r
	} else if n == n.parent.left {
		n.parent.left = r
	} else {
		n.parent.right = r
	}
	r.left = n
	n.parent = r
}

fn (mut t RBTree[T]) rotate_right[T](node &Node[T]) {
	mut n := &unsafe { *node }
	mut l := n.left
	n.left = l.right
	if unsafe { l.right != 0 } {
		l.right.parent = n
	}
	l.parent = n.parent
	if unsafe { n.parent == 0 } {
		t.root = l
	} else if n == n.parent.right {
		n.parent.right = l
	} else {
		n.parent.left = l
	}
	l.right = n
	n.parent = l
}

fn (t RBTree[T]) min[T](node &Node[T]) &Node[T] {
	mut n := unsafe { node }
	for unsafe { n.left != 0 } {
		n = n.left
	}
	return n
}
