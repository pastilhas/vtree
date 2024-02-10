module main

import avl
import rand

fn main() {
	mut t := avl.new[int](compare)
	mut a := []int{cap: 1_000_000}
	mut c := []int{cap: 256}

	for i := 0; i < 1_000_000; i++ {
		n := rand.u8()
		a << n

		if n !in c {
			c << n
		}
	}

	for i := 0; i < 1_000_000; i++ {
		t.insert(unsafe { &a[i] })
	}

	b := t.to_array()

	assert b.len == c.len
	for i := 1; i < b.len; i++ {
		assert b[i - 1] < b[i]
	}
}

fn compare(a int, b int) int {
	return if a < b {
		-1
	} else if a > b {
		1
	} else {
		0
	}
}
