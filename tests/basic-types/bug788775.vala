void test_compile_only () {
	try {
		var file = new KeyFile ();
		var list = file.get_string_list ("foo", "bar");
	} catch (KeyFileError e) {
	}
}

void main () {
}
