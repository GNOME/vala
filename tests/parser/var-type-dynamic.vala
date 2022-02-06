class Foo : Object {
	[CCode (cname = "manam")]
	public string bar { owned get; set; default = "foo"; }
}

void main () {
	var foo = new Foo ();
	var foo_list = new List<Foo> ();
	foo_list.prepend (foo);

	{
		dynamic var bar = foo;
		string s = bar.manam;
		assert (s == "foo");
	}
	{
		dynamic unowned var bar = foo;
		string s = bar.manam;
		assert (s == "foo");
	}
	{
		dynamic var? bar = foo;
		string s = bar.manam;
		assert (s == "foo");
	}
	{
		dynamic unowned var? bar = foo;
		string s = bar.manam;
		assert (s == "foo");
	}
	{
		foreach (dynamic var bar in foo_list) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		foreach (dynamic unowned var bar in foo_list) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		foreach (dynamic var? bar in foo_list) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		foreach (dynamic unowned var? bar in foo_list) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		with (dynamic var bar = foo) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		with (dynamic unowned var bar = foo) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		with (dynamic var? bar = foo) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
	{
		with (dynamic unowned var? bar = foo) {
			string s = bar.manam;
			assert (s == "foo");
		}
	}
}
