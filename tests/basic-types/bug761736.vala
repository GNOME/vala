const string[] FOO = { "foo", "bar" };

unowned string[] transfer_none () {
	return FOO;
}

(unowned string)[] transfer_container () {
	return FOO;
}

string[] transfer_full () {
	return FOO;
}

void main () {
	var bar = FOO;

	for (int i = 0; i < 42; i++) {
		string[] baz = bar;
	}

	for (int i = 0; i < 42; i++) {
		unowned string[] a = transfer_none ();
		assert ("foo" in a);
		assert ("bar" in a);
	}

	for (int i = 0; i < 42; i++) {
		(unowned string)[] a = transfer_container ();
		assert ("foo" in a);
		assert ("bar" in a);
	}

	for (int i = 0; i < 42; i++) {
		string[] a = transfer_full ();
		assert ("foo" in a);
		assert ("bar" in a);
	}

	assert ("foo" in FOO);
	assert ("bar" in FOO);
}
