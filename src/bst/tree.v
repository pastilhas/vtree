module bst

const max_height = 32

struct Tree[T] {
mut:
	cmp  fn (T, T) int @[required]
	root &Node[T] = unsafe { 0 }
	size usize
}

pub fn new[T](cmp fn (T, T) int) Tree[T] {
	return Tree[T]{
		cmp: cmp
	}
}

pub fn (t &Tree[T]) find(k &T) ?&T {
	mut p := t.root

	assert unsafe { k != 0 }

	for unsafe { p != 0 } {
		cmp := t.cmp(k, p.data)

		if cmp < 0 {
			p = p.left
		} else if cmp > 0 {
			p = p.right
		} else {
			return p.data
		}
	}

	return none
}

pub fn (t &Tree[T]) exists(k &T) bool {
	t.find(k) or { return false }
	return true
}

fn set_child[T](mut p Node[T], q &Node[T], right int) {
	if right > 0 {
		p.right = q
	} else {
		p.left = q
	}
}

/*
pub fn (mut t Tree[T]) balance() {
	// tree to vine
	mut q := t.root
	mut p := t.root

	for unsafe { p != 0 } {
		if unsafe { p.right == 0 } {
			q = p
			p = p.left
		} else {
			r := p.right
			p.right = r.left
			p = r
			q.left = r
		}
	}

	// vine to tree
	mut l := t.size + 1
	mut next := l & (l - 1)
	for next != 0 {
		l = next
		next = l & (l - 1)
	}

	l = t.size + 1 - l

	compress[T](t.root, l)

	mut v := t.size - l
	mut h := 1 + int(l > 0)
	for v > 1 {
		compress[T](t.root, v / 2)
		v /= 2
		h++
	}

	assert h <= bst.max_height
	assert t.is_valid()
}

fn compress[T](n &Node[T], c usize) {
	assert unsafe { n != 0 }

	mut root := *n

	mut count := c
	for count > 0 {
		mut r := root.left
		mut b := r.left

		root.left = b
		r.left = b.right
		b.right = r
		root = *b
		count--
	}
}
*/

fn (t Tree[T]) is_valid() bool {
	return node_is_valid[T](t.root)
}

fn node_is_valid[T](n &Node[T]) bool {
	return unsafe { n == 0 } || (node_is_valid[T](n.left) && node_is_valid[T](n.right))
}
