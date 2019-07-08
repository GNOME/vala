[CCode (has_type_id = false)]
struct Bar {
	public int i;
	public int j;
}

void foo (int first_arg, ...) {
	var args = va_list ();
	Bar bar = args.arg ();

	assert (first_arg == 42);
	assert (bar.i == 23);
	assert (bar.j == 4711);
}

void faz (int first_arg, ...) {
	var args = va_list ();
	Bar* bar = args.arg ();

	assert (first_arg == 23);
	assert (bar.i == 23);
	assert (bar.j == 4711);
}

void fab (int first_arg, ...) {
	var args = va_list ();
	Bar? bar = args.arg ();

	assert (first_arg == 65);
	assert (bar.i == 23);
	assert (bar.j == 4711);
}

void main () {
	Bar bar = {23, 4711};

	foo (42, bar);
	faz (23, bar);
	fab (65, bar);
}
