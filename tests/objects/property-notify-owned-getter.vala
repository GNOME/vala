class Bar : Object {
}

struct Manam {
	public string s;
}

class Foo : Object {
	public Bar o { owned get; set; }

	public Manam st { owned get; set; }

	public Manam? stn { owned get; set; }

	public string s { owned get; set; }

	public string[] strv { owned get; set; }

	construct {
		o = bar;
		st = { "foo" };
		stn = { "bar" };
		s = "foo";
		strv = { "foo", "bar" };
	}
}

Bar bar;

void main () {
	bar = new Bar ();
	assert (bar.ref_count == 1);

	var foo = new Foo ();
	assert (bar.ref_count == 2);
	foo.o = bar;
	assert (bar.ref_count == 2);

	assert (foo.st.s == "foo");
	foo.st = { "manam" };
	assert (foo.st.s == "manam");

	assert (foo.stn.s == "bar");
	foo.stn = { "minim" };
	assert (foo.stn.s == "minim");

	assert (foo.s == "foo");
	foo.s = "manam";
	assert (foo.s == "manam");

	assert (foo.strv[1] == "bar");
	foo.strv = { "manam", "minim" };
	assert (foo.strv[1] == "minim");
}
