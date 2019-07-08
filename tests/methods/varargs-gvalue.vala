void foo (int first_arg, ...) {
	var args = va_list ();
	Value val = args.arg ();

	assert (first_arg == 42);
	assert (val.holds (typeof (string)));
	assert (val.get_string () == "foo");
}

void faz (int first_arg, ...) {
	var args = va_list ();
	Value* val = args.arg ();

	assert (first_arg == 23);
	assert (val.holds (typeof (string)));
	assert (val.get_string () == "foo");
}

void main () {
	Value val = Value (typeof (string));
	val.set_string ("foo");

	foo (42, val);
	faz (23, val);
}
