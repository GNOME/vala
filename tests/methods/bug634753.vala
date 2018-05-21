void foo ([CCode (array_length_type = "gsize")] ref uint8[] a) {
}

void bar ([CCode (array_length_type = "gsize")] uint8[] a) {
}

void main () {
	uint8[] a = new uint8[32];
	foo (ref a);
}
