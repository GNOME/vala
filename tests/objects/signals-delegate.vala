public delegate string FooFunc (Foo foo, string s);

public class Foo : Object {
	public signal string test (string s);

	public void add (FooFunc func) {
		test.connect (func);
	}

	public void add_owned (owned FooFunc func) {
		test.connect (func);
	}

	public void add_remove (FooFunc func) {
		test.connect (func);
		test.disconnect (func);
	}

	public void add_remove_owned (owned FooFunc func) {
		test.connect (func);
		test.disconnect (func);
	}

	public void invoke_test () {
		assert (test ("bar") == "foo");
	}

	public void invoke_test_empty () {
		assert (test ("bar") == null);
	}
}

public class Bar : Object {
	public signal string test (string s);

	int i;

	public Bar (Foo foo) {
		i = 42;
		foo.add (instance_callback);
	}

	public Bar.owned (Foo foo) {
		i = 42;
		foo.add_owned (instance_callback);
	}

	public Bar.remove (Foo foo) {
		i = 42;
		foo.add_remove (instance_callback);
	}

	public Bar.remove_owned (Foo foo) {
		i = 42;
		foo.add_remove_owned (instance_callback);
	}

	string instance_callback (Foo foo, string s) {
		assert (foo is Foo);
		assert (this is Bar);
		assert (s == "bar");
		assert (i == 42);
		return "foo";
	}
}

string callback_static (Foo foo, string s) {
	assert (foo is Foo);
	assert (s == "bar");
	return "foo";
}

void main () {
	Foo foo;
	Bar bar;

	foo = new Foo ();
	foo.add ((FooFunc) callback_static);
	foo.invoke_test ();

	foo = new Foo ();
	foo.add_owned ((FooFunc) callback_static);
	foo.invoke_test ();

	foo = new Foo ();
	foo.add_remove ((FooFunc) callback_static);
	foo.invoke_test_empty ();

	foo = new Foo ();
	foo.add_remove_owned ((FooFunc) callback_static);
	foo.invoke_test_empty ();

	foo = new Foo ();
	bar = new Bar (foo);
	foo.invoke_test ();

	foo = new Foo ();
	bar = new Bar.owned (foo);
	foo.invoke_test ();

	foo = new Foo ();
	bar = new Bar.remove (foo);
	foo.invoke_test_empty ();

	foo = new Foo ();
	bar = new Bar.remove_owned (foo);
	foo.invoke_test_empty ();
}
