int[] foo() {
	int bar[8];
	bar[7] = 42;
	return bar;
}

void main () {
	var bar = foo ();
	assert (bar[7] == 42);
}
