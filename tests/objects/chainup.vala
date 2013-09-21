class FooBase {
	public int bar;

	public FooBase (int _, ...) {
		va_list v = va_list ();
		bar = v.arg ();
	}

	public FooBase.baz (int _, ...) {
		va_list v = va_list ();
		this (_, v);
	}
}

class Foo : FooBase {
	public Foo (int _, ...) {
		va_list v = va_list ();
		base (_, v);
	}

	public Foo.baz (int _, ...) {
		va_list v = va_list ();
		base.baz (_, v);
	}

	public Foo.qux (int _, ...) {
		va_list v = va_list ();
		this.baz (_, v);
	}
}

void main () {
	var foo = new Foo (0, 10);
	assert (foo.bar == 10);
	foo = new Foo.baz (0, 20);
	assert (foo.bar == 20);
	foo = new Foo.qux (0, 30);
	assert (foo.bar == 30);
}
