const int[] FOO = { 0, 1, 2 };

[CCode (array_length = false, array_length_cexpr = "3")]
unowned int[] get_foo () {
	assert (FOO.length == 3);
	return FOO;
}

void main () {
	assert (get_foo ().length == 3);
}
