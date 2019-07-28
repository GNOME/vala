errordomain Foo {
	BAD = 23;

	public static Foo from_string (string error) {
		assert (error == "BAD");
		return new Foo.BAD ("BAD");
	}
}

void main () {
	var e = Foo.from_string ("BAD");
	assert (e.code == Foo.BAD);
}
