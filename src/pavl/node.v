module pavl

@[heap]
struct PAVLNode[T] {
	data &T
mut:
	left   &PAVLNode[T] = unsafe { 0 }
	right  &PAVLNode[T] = unsafe { 0 }
	parent &PAVLNode[T] = unsafe { 0 }
	bf     i8
}

fn new_node[T](k &T) &PAVLNode[T] {
	return &PAVLNode[T]{
		data: unsafe { k }
	}
}
