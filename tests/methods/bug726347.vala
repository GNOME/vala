class Foo {
	public int count_strings (...) {
		var i = 0;
		var args = va_list();
		for (string? str = args.arg<string?>(); str != null; str = args.arg<string?>()) {
			i++;
		}
		return i;
	}
}

void main() {
	var foo = new Foo ();
	int count = foo.count_strings ("foo", "bar", "baz");
	assert (count == 3);
}