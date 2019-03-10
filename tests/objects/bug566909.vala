class Maman.Foo : Object {
	[Signal (detailed = true)]
	public signal void bar ();
}

void main () {
	bool detailed1 = false;
	bool detailed2 = false;
	bool detailed3 = false;
	string detail1 = "detail1";
	string detail2 = "detail2";

	var foo = new Maman.Foo ();
	foo.bar[detail1].connect (() => { detailed1 = true; });
	foo.bar[detail2].connect (() => { detailed2 = true; });
	foo.bar["detail3"].connect (() => { detailed3 = true; });
	foo.bar[detail1] ();
	foo.bar[detail2] ();
	foo.bar["detail3"] ();
	assert (detailed1 && detailed2 && detailed3);
}
