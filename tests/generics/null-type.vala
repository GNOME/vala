void foo<T> (T t) {
	assert (t == null);
	assert (typeof (T) == Type.INVALID);
	assert (T.dup == null);
	assert (T.destroy == null);
}

void main () {
	foo (null);
}
