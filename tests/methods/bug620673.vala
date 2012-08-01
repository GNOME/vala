void foo (int bar, ...) throws Error {
	assert (bar == 42);
	var args = va_list ();
	int arg = args.arg ();
	assert (arg == 23);
}

void main () {
	foo (42, 23);
}
