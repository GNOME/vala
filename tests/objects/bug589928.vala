class Foo {
	public List<string> bar { get; owned set; default = new List<string> (); }
}

void main () {
	Foo foo = new Foo ();
	foo.bar.append ("1");
	assert (foo.bar.nth_data (0) == "1");
}
