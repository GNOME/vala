class Foo : Object {
	[CCode (notify = false)]
	public string foo { get; set; }

	public string bar { get; set; }

	public string manam { get; set; }
}

void fail () {
	assert_not_reached ();
}

int counter;
void count () {
	counter++;
}

void main () {
	var foo = new Foo ();

	foo.notify["foo"].connect (fail);
	//FIXME Requires --target-glib=2.42 for G_PARAM_EXPLICIT_NOTIFY to be actually added
	//foo.set_property ("foo", "foo");
	foo.foo = "foo";

	counter = 0;
	foo.notify["bar"].connect (count);
	foo.bar = "bar";
	assert (counter == 1);

	counter = 0;
	foo.notify["manam"].connect (count);
	foo.set_property ("manam", "manam");
	assert (counter == 1);
}
