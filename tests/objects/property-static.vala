class Foo {
	static int _bar;
	static int _baz;

	public static int bar {
		get { assert_not_reached (); }
		set { _bar = value; assert (_bar == 23); }
	}

	public static int baz {
		set { _baz = value; assert (_baz == 42); }
	}

	public static int boo { set; }
}

struct Bar {
	public int foo;

	static int _bar;
	static int _baz;

	public static int bar {
		get { assert_not_reached (); }
		set { _bar = value; assert (_bar == 23); }
	}

	public static int baz {
		set { _baz = value; assert (_baz == 42); }
	}

	public static int boo { set; }
}

void main () {
	Foo.bar = 23;
	Foo.baz = 42;
	Foo.boo = 4711;

	Bar.bar = 23;
	Bar.baz = 42;
	Bar.boo = 4711;
}
