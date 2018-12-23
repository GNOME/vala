class Foo : Object {
	public string? name { get; set; }
	public int id { get; set; }
}

bool get_foo_varg (string s, ...) {
	var args = va_list ();
	Foo** out_foo = args.arg ();
	*out_foo = foo_static.ref ();
	return true;
}

Foo foo_static;

void main () {
	{
		foo_static = new Foo ();
	}
	assert (foo_static.ref_count == 1);

	{
		Foo foo;

		get_foo_varg ("foo", out foo);
		assert (foo.ref_count == 2);

		if (get_foo_varg ("foo", out foo)) {
			assert (foo.ref_count == 2);
		}
		assert (foo.ref_count == 2);
	}
	assert (foo_static.ref_count == 1);

	{
		foo_static.@set ("name", "foo", "id", 42);

		string? name;
		int id;
		foo_static.@get ("name", out name, "id", out id);
		assert (name == "foo");
		assert (id == 42);
	}
}
