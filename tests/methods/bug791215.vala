[PrintfFormat]
void foo_print (string? fmt, ...) {
	assert (fmt == null);
}

void main () {
	foo_print (null);
}
