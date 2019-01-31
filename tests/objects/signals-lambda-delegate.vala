class Foo : Object {
	public signal void bar (string s);
	public signal void baz (string s);
}

delegate void FooFunc (Foo foo, string s);

void main () {
	var foo = new Foo ();
	ulong bar_id = 0U;
	ulong baz_id = 0U;
	{
		FooFunc callback = (f,s) => {
			assert (s == "bar" || s == "baz");

			if (s == "bar") {
				assert (bar_id > 0U);
				f.disconnect (bar_id);
				bar_id = 0U;
			}

			if (s == "baz") {
				assert (baz_id > 0U);
				f.disconnect (baz_id);
				baz_id = 0U;
			}
		};

		bar_id = foo.bar.connect (callback);
		baz_id = foo.baz.connect (callback);
	}
	{
		foo.bar ("bar");
		assert (bar_id == 0U);

		foo.baz ("baz");
		assert (baz_id == 0U);
	}
}
