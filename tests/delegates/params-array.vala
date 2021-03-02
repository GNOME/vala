[CCode (has_target = false)]
delegate void FooFunc (params string[] strv);

void foo (params string[] strv) {
	assert (strv.length == 3);
	assert (strv[0] == "foo");
	assert (strv[1] == "bar");
	assert (strv[2] == "manam");
}

[CCode (has_target = false)]
delegate void BarFunc (params int[] intv);

void bar (params int[] intv) {
	assert (intv.length == 3);
	assert (intv[0] == 23);
	assert (intv[1] == 42);
	assert (intv[2] == 4711);
}

[CCode (has_target = false)]
delegate void ManamFunc (params Value?[] valuev);

void manam (params Value?[] valuev) {
	assert (valuev.length == 3);
	assert (valuev[0] == "foo");
	assert (valuev[1] == 4711);
	assert (valuev[2] == 3.1415);
}

[CCode (has_target = false)]
delegate void ManamOwnedFunc (params owned Value?[] valuev);

void manam_owned (params owned Value?[] valuev) {
	assert (valuev.length == 3);
	assert (valuev[0] == "foo");
	assert (valuev[1] == 4711);
	assert (valuev[2] == 3.1415);
}

[CCode (has_target = false)]
delegate void MinimFunc (params Variant[] variantv);

void minim (params Variant[] variantv) {
	assert (variantv.length == 3);
	assert ((string) variantv[0] == "foo");
	assert ((int) variantv[1] == 4711);
	assert ((double) variantv[2] == 3.1415);
}

void main () {
	{
		FooFunc func = foo;
		func ("foo", "bar", "manam");
	}
	{
		BarFunc func = bar;
		func (23, 42, 4711);
	}
	{
		ManamFunc func = manam;
		func ("foo", 4711, 3.1415);
	}
	{
		ManamOwnedFunc func = manam_owned;
		func ("foo", 4711, 3.1415);
	}
	{
		MinimFunc func = minim;
		func ("foo", 4711, 3.1415);
	}
}
