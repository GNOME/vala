class Foo : Object {
	[CCode (array_length = false, array_null_terminated = true)]
	[NoAccessorMethod]
	public string[] bar { owned get; set; }
}

void main () {
	string[] bar = { "foo", "bar", "manam" };
	var foo = new Foo ();
	foo.bar = bar;

	var manam = foo.bar;
	assert (manam.length == 3);
	assert (manam[2] == "manam");
}
