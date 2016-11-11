class Foo : Object {
	[Description (nick = "foo's nick", blurb = "foo's blurb")]
	public int foo { get; set; }
}

void main () {
	var foo = new Foo ();
	(unowned ParamSpec)[] properties = foo.get_class ().list_properties ();
	foreach (unowned ParamSpec p in properties) {
		assert (p.get_name () == "foo");
		assert (p.get_nick () == "foo's nick");
		assert (p.get_blurb () == "foo's blurb");
	}
}
