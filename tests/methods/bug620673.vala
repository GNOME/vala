void foo (int bar, ...) throws Error {
	assert (bar == 42);
	var args = va_list ();
	int arg = args.arg ();
	int64 arg2 = args.arg ();
	double arg3 = args.arg ();
	assert (arg == 23);
	assert (arg2 == 4711LL);
	assert (arg3 == 3.1415);
}

void main () {
	foo (42, 23, 4711LL, 3.1415);
}
