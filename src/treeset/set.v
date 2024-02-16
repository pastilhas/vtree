module treeset

import avl

pub struct TreeSet[T] {
mut:
	tree avl.Tree[T]
}

pub fn new[T](cmp fn (T, T) int) TreeSet[T] {
	return TreeSet[T]{
		tree: avl.new(cmp)
	}
}

pub fn (mut s TreeSet[T]) add[T](k T) bool {
	return s.tree.insert(k)
}

pub fn (mut s TreeSet[T]) rem[T](k T) bool {
	return s.tree.remove(k)
}

pub fn (mut s TreeSet[T]) min[T]() !T {
	return s.tree.min()!
}

pub fn (mut s TreeSet[T]) max[T]() !T {
	return s.tree.max()!
}

pub fn (s TreeSet[T]) len[T]() int {
	return s.tree.size
}

pub fn (s TreeSet[T]) empty[T]() bool {
	return s.tree.size == 0
}

pub fn (s TreeSet[T]) str[T]() string {
	return s.array().str()
}

pub fn (s TreeSet[T]) array[T]() []T {
	return s.tree.array()
}
