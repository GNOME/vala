[PrintfFormat]
string foo (string format, ...) {
	return format.vprintf (va_list ());
}

void main () {
	assert (foo ("%s", "foo") == "foo");
}
