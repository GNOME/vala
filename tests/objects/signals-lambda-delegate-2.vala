delegate string FooFunc (Foo foo, string s);

class Foo : Object {
	public signal string test (string s);
}

class Bar : Object {
	construct {
		var foo = new Foo ();
		FooFunc func = (f,s) => {
			assert (s == "foo");
			return s;
		};
		foo.test.connect (func);
		assert (foo.test ("foo") == "foo");
		foo.test.disconnect (func);
		foo.test ("bar");
	}

	public void run () {
		var foo = new Foo ();
		FooFunc func = (f,s) => {
			assert (s == "foo");
			return s;
		};
		foo.test.connect (func);
		assert (foo.test ("foo") == "foo");
		foo.test.disconnect (func);
		foo.test ("bar");
	}
}

delegate string FazFunc (Faz faz, string s);

class Faz {
	public signal string test (string s);
}

class Boo {
	public Boo () {
		var faz = new Faz ();
		FazFunc func = (f,s) => {
			assert (s == "faz");
			return s;
		};
		faz.test.connect (func);
		assert (faz.test ("faz") == "faz");
		faz.test.disconnect (func);
		faz.test ("boo");
	}

	public void run () {
		var faz = new Faz ();
		FazFunc func = (f,s) => {
			assert (s == "faz");
			return s;
		};
		faz.test.connect (func);
		assert (faz.test ("faz") == "faz");
		faz.test.disconnect (func);
		faz.test ("boo");
	}
}

void main () {
	{
		var bar = new Bar ();
		bar.run ();

		var foo = new Foo ();
		FooFunc func = (f,s) => {
			assert (s == "foo");
			return s;
		};
		foo.test.connect (func);
		assert (foo.test ("foo") == "foo");
		foo.test.disconnect (func);
		foo.test ("bar");
	}
	{
		var boo = new Boo ();
		boo.run ();

		var faz = new Faz ();
		FazFunc func = (f,s) => {
			assert (s == "faz");
			return s;
		};
		faz.test.connect (func);
		assert (faz.test ("faz") == "faz");
		faz.test.disconnect (func);
		faz.test ("boo");
	}
}
