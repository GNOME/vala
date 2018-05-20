void foo ([CCode (array_length_type = "gsize")] ref uint8[] a) {
	assert (a.length == 32);
}

void main () {
	uint8[] a = new uint8[32];
	foo (ref a);
}
