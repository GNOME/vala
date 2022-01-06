[CCode (has_target = false)]
delegate unowned uint8[:uint64] ManamFunc (uint8[:size_t] param);

unowned uint8[:uint64] manam (uint8[:size_t] param) {
	assert (param.length == 2147483648LL);
	return param;
}

uint8[:size_t] field;

void test_pass () {
	var foo = new uint8[2147483648LL:ssize_t];
	assert (foo.length == 2147483648LL);

	ManamFunc func = manam;
	unowned var bar = func (foo);
	assert (bar.length == 2147483648LL);

	field = (owned) foo;
	assert (field.length == 2147483648LL);

	field = null;
}

void foo (ref uint8[:ssize_t] param) {
	param = new uint8[2147483648LL:ssize_t];
}

void test_ref () {
	var a = new uint8[:ssize_t] {};
	foo (ref a);
	assert (a.length == 2147483648LL);
}

void bar (out uint8[:ssize_t] param) {
	param = new uint8[2147483648LL:ssize_t];
}

void test_out () {
	uint8[:ssize_t] a;
	bar (out a);
	assert (a.length == 2147483648LL);
}

void main () {
	if (ssize_t.MAX < 2147483648LL) {
		//FIXME skip runtime while there is still c-expected
		return;
	}

	test_pass ();
	test_ref ();
	test_out ();
}
