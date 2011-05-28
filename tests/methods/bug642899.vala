class Foo {
	Object bar;
	public Foo () {
		Object baz = null;
		SourceFunc f = () => {
			baz = bar;
			return false;
		};
		f ();
	}
}

void main () {
	new Foo ();
}
