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
	t.insert_fixup(node)
	return true
}

fn (mut t RBTree[T]) insert_fixup[T](node &Node[T]) {
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
	return false
}

fn (mut t RBTree[T]) delete_fixup[T](node &Node[T]) {
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
