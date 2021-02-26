public enum Foo {
	BAR,
	BAZ
}

void main () {
	assert (Foo.BAR.to_string () == "FOO_BAR");
}
