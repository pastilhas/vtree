module main

import avl
import rand
import time

fn main() {
	items := int(1e7)
	mut t := avl.new[f64](compare)
	mut a := []f64{cap: items}

	for i := 0; i < items; i++ {
		a << rand.f64()
	}

	sw := time.new_stopwatch()
	for i := 0; i < items; i++ {
		t.insert(unsafe { &a[i] })
	}
	println('${sw.elapsed()}')
}

fn compare(a f64, b f64) int {
	return if a < b {
		-1
	} else if a > b {
		1
	} else {
		0
	}
}
