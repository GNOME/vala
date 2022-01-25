class Foo : Object {
	public string manam { get; set; default = "foo"; }
}

void main () {
	var foo = new Foo ();
	var foo_list = new List<Foo> ();
	foo_list.prepend (foo);

	{
		dynamic var bar = foo;
		assert (bar.manam == "foo");
	}
	{
		dynamic unowned var bar = foo;
		assert (bar.manam == "foo");
	}
	{
		dynamic var? bar = foo;
		assert (bar.manam == "foo");
	}
	{
		dynamic unowned var? bar = foo;
		assert (bar.manam == "foo");
	}
	{
		foreach (dynamic var bar in foo_list) {
			assert (bar.manam == "foo");
		}
	}
	{
		foreach (dynamic unowned var bar in foo_list) {
			assert (bar.manam == "foo");
		}
	}
	{
		foreach (dynamic var? bar in foo_list) {
			assert (bar.manam == "foo");
		}
	}
	{
		foreach (dynamic unowned var? bar in foo_list) {
			assert (bar.manam == "foo");
		}
	}
	{
		with (dynamic var bar = foo) {
			assert (manam == "foo");
		}
	}
	{
		with (dynamic unowned var bar = foo) {
			assert (manam == "foo");
		}
	}
	{
		with (dynamic var? bar = foo) {
			assert (manam == "foo");
		}
	}
	{
		with (dynamic unowned var? bar = foo) {
			assert (manam == "foo");
		}
	}
}
