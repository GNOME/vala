enum Foo {
	BAR;

	public string bar () {
		return to_string ();
	}
}

void main () {
	assert (Foo.BAR.bar () == "FOO_BAR");
}
