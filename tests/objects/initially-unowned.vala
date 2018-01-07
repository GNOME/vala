class Foo : Object {
	public string foo { get; construct; }
}

void main () {
	Foo foo;

	foo = (Foo) Object.@new (typeof (Foo), "foo", "foo.initially");
	assert (foo.foo == "foo.initially");
}
