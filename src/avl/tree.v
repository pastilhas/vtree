module avl

const max_height = 92

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

pub fn (mut t Tree[T]) insert(k &T) bool {
	mut z := t.root
	mut y := t.root
	mut q := z
	mut p := y
	mut dir := false
	mut da := []bool{cap: avl.max_height}
	mut a := 0

	for unsafe { p != 0 } {
		cmp := t.cmp(k, p.data)

		if cmp == 0 {
			return false
		}

		if p.bf != 0 {
			z = q
			y = p
			a = 0
		}

		dir = cmp > 0
		da[a++] = dir

		q = p
		p = if dir {
			p.right
		} else {
			p.left
		}
	}

	mut n := new_node(k)
	if dir {
		q.right = n
	} else {
		q.left = n
	}

	t.size++

	if unsafe { y == 0 } {
		return true
	}

	mut w := &Node(unsafe { 0 })

	return true
}

pub fn (mut t Tree[T]) remove(k &T) bool {
	mut p := t.root
	mut q := &Node(unsafe { 0 })
	mut cmp := 0

	assert unsafe { k != 0 }

	for unsafe { p != 0 } {
		cmp = t.cmp(k, p.data)

		if cmp < 0 {
			q = p
			p = p.left
		} else if cmp > 0 {
			q = p
			p = p.right
		} else {
			break
		}
	}

	if unsafe { p == 0 } {
		return false
	}

	if unsafe { p.right == 0 } {
		t.add_child(q, p.left)
	} else {
		mut r := p.right
		if unsafe { r.left == 0 } {
			r.left = p.left
			t.add_child(q, r)
		} else {
			mut s := r.left
			for unsafe { s.left != 0 } {
				s = s.left
			}

			r.left = s.right
			s.left = p.left
			s.right = p.right
			t.add_child(q, s)
		}
	}

	assert t.is_valid()

	t.size--
	return true
}
