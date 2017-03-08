class Foo : Object {
	[Description (nick = "foo's nick", blurb = "foo's blurb")]
	public int foo { get; set; }
}

enum Bar {
	[Description (nick = "foo's nick")]
	FOO
}

void main () {
	var foo = new Foo ();
	(unowned ParamSpec)[] properties = foo.get_class ().list_properties ();
	foreach (unowned ParamSpec p in properties) {
		assert (p.get_name () == "foo");
		assert (p.get_nick () == "foo's nick");
		assert (p.get_blurb () == "foo's blurb");
	}

	assert (((EnumClass) typeof (Bar).class_ref ()).get_value_by_name (Bar.FOO.to_string ()).value_nick == "foo's nick");
}
