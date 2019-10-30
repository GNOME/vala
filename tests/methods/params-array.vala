void foo (params string[] strv) {
	assert (strv.length == 3);
	assert (strv[0] == "foo");
	assert (strv[1] == "bar");
	assert (strv[2] == "manam");
}

void bar (params int[] intv) {
	assert (intv.length == 3);
	assert (intv[0] == 23);
	assert (intv[1] == 42);
	assert (intv[2] == 4711);
}

void manam (params Value?[] valuev) {
	assert (valuev.length == 3);
	assert (valuev[0] == "foo");
	assert (valuev[1] == 4711);
	assert (valuev[2] == 3.1415);
}

void manam_owned (params owned Value?[] valuev) {
	assert (valuev.length == 3);
	assert (valuev[0] == "foo");
	assert (valuev[1] == 4711);
	assert (valuev[2] == 3.1415);
}

void minim (params Variant[] variantv) {
	assert (variantv.length == 3);
	assert ((string) variantv[0] == "foo");
	assert ((int) variantv[1] == 4711);
	assert ((double) variantv[2] == 3.1415);
}

void main () {
	foo ("foo", "bar", "manam");
	bar (23, 42, 4711);
	manam ("foo", 4711, 3.1415);
	manam_owned ("foo", 4711, 3.1415);
	minim ("foo", 4711, 3.1415);
}
