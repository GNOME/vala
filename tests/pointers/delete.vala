class Foo {
}

class Bar : Foo {
}

void main () {
	{
		Foo* foo = new Foo ();
		delete foo;
	}
	{
		Bar* bar = new Bar ();
		delete bar;
	}
}
