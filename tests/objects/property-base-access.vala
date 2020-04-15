class Foo {
	public string prop { get; set; }

	public Foo () {
		prop = "foo";
	}
}

class Bar : Foo {
	public new string prop { get; set; }

	public Bar () {
		prop = "bar";

		assert (base.prop == "foo");
		base.prop = "manam";
		assert (base.prop == "manam");

		assert (prop == "bar");
	}
}

void main () {
	var bar = new Bar ();
}
