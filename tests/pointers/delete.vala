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
	{
		StringBuilder* foo = new StringBuilder ();
		foo->append ("foo");
		delete foo;
	}
}
