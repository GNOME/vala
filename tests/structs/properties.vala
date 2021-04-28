struct Foo {
	public int i { get; set; }
	public string s { get; set; }
	public string os { owned get; set; }

	public string s_get {
		get {
			return _s;
		}
	}

	public string s_set {
		set {
			_s = value;
		}
	}
}

void main () {
	{
		Foo foo = { 23, "foo", "bar" };
		assert (foo.i == 23);
		assert (foo.s == "foo");
		assert (foo.s_get == "foo");
		assert (foo.os == "bar");

		foo.i = 42;
		foo.s_set = "bar";
		foo.os = "manam";
		assert (foo.i == 42);
		assert (foo.s == "bar");
		assert (foo.s_get == "bar");
		assert (foo.os == "manam");
	}
}
