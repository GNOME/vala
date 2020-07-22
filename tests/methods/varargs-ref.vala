void set_foo_varg (string s, ...) {
	var args = va_list ();
	string** ref_s1 = args.arg ();
	*ref_s1 = "bar";
	string** ref_s2 = args.arg ();
	*ref_s2 = "manam";
}

void main () {
	unowned string bar = "", manam = "";
	set_foo_varg ("foo", ref bar, ref manam);
	assert (bar == "bar");
	assert (manam == "manam");
}
