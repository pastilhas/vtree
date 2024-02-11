module avl

pub fn (mut t AVLTree[T]) remove[T](k &T) bool {
	assert unsafe { k != 0 }

	if unsafe { t.root == 0 } {
		return false
	}

	mut p := t.root
	mut cmp := 0
	mut pa := []&AVLNode[T]{cap: max_height}
	mut da := []bool{cap: max_height}

	for unsafe { p != 0 } {
		cmp = t.cmp(k, p.data)

		if cmp == 0 {
			break
		}

		pa << p
		da << cmp < 0

		if cmp < 0 {
			p = p.left
		} else {
			p = p.right
		}
	}

	if unsafe { p == 0 } {
		return false
	}

	t.size--
	if unsafe { p.right == 0 } {
		mut l := pa.last()
		if da.last() {
			l.left = p.left
		} else {
			l.right = p.left
		}
	} else {
		mut r := p.right

		if unsafe { r.left == 0 } {
			r.left = p.left
			r.bf = p.bf

			mut l := pa.last()
			d := da.last()

			if d {
				l.left = r
			} else {
				l.right = r
			}

			pa << r
			da << false
		} else {
			j := pa.len
			pa << &AVLNode[T](unsafe { 0 })
			da << false
			pa << r
			da << true
			mut s := r.left

			for unsafe { s.left != 0 } {
				r = s
				pa << r
				da << true
				s = r.left
			}

			s.left = p.left
			r.left = s.right
			s.right = p.right
			s.bf = p.bf

			mut w := pa[j - 1]
			if da[j - 1] {
				w.left = s
			} else {
				w.right = s
			}

			pa[j] = s
			da[j] = false
		}
	}

	mut i := pa.len - 1
	for i > 0 {
		mut y := pa[i]
		if da[i] {
			y.bf++
			if y.bf == 1 {
				break
			} else if y.bf == 2 {
				mut x := y.right
				if x.bf == -1 {
					w := t.double_rotate_left(mut y)
					mut z := pa[i - 1]
					if da[i - 1] {
						z.left = w
					} else {
						z.right = w
					}
				} else {
					y.right = x.left
					x.left = y
					mut z := pa[i - 1]

					if da[i - 1] {
						z.left = x
					} else {
						z.right = x
					}

					if x.bf == 0 {
						x.bf = -1
						y.bf = 1
						break
					} else {
						x.bf = 0
						y.bf = 0
					}
				}
			}
		} else {
			y.bf--
			if y.bf == -1 {
				break
			} else if y.bf == -2 {
				mut x := y.left
				if x.bf == 1 {
					w := t.double_rotate_right(mut y)
					mut z := pa[i - 1]
					if da[i - 1] {
						z.left = w
					} else {
						z.right = w
					}
				} else {
					y.left = x.right
					x.right = y

					mut z := pa[i - 1]
					if da[i - 1] {
						z.left = x
					} else {
						z.right = x
					}

					if x.bf == 0 {
						x.bf = 1
						y.bf = -1
						break
					} else {
						x.bf = 0
						y.bf = 0
					}
				}
			}
		}

		i--
	}

	assert t.is_valid()
	return true
}
