class Foo<G> : Object {
	public G g_data { get; set; }

	public Foo (G g_data) {
		Object (g_data: g_data);
	}
}

void main () {
	{
		var foo = new Foo<Object> (new Object ());
		assert (foo.g_data is Object);
	}
	{
		var foo = new Foo<string> ("foo");
		assert (foo.g_data == "foo");
	}
}
