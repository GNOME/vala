class Foo {
	public class int foo = 42;

	public class int get_foo () {
		return 23;
	}

	public static void manam (TypeClass t) {
		assert (t.get_type ().is_a (typeof (Foo)));
	}
}

class Bar : Foo {
	static construct {
		assert (foo == 42);
		class.foo = 4711;
		assert (class.foo == 4711);
		assert (class.get_foo () == 23);
		//FIXME manam (class);
	}

	public Bar () {
		assert (this.get_foo () == 42);
		assert (get_foo () == 42);
		assert (foo == 4711);
		assert (class.foo == 4711);
		assert (class.get_foo () == 23);
		//FIXME manam (class);
	}

	public int get_foo () {
		assert (foo == 4711);
		assert (class.foo == 4711);
		//FIXME manam (class);
		return 42;
	}
}

void main() {
	var bar = new Bar ();

	//FIXME assert (classof (Bar).foo == 4711);
	//FIXME assert (classof (Bar).get_foo () == 23);
}
