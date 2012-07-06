public class Foo {

	public GLib.GenericArray<string> paramlist;
	public bool used_test;

	public Foo (string msg, ...) throws Error {
		string arg = msg;
		va_list args = va_list ();
		paramlist = new GLib.GenericArray<string> ();
		while (arg != null) {
			paramlist.add (arg);
			arg = args.arg ();
		}
		used_test = false;
	}

	public Foo.test (string msg) {
		paramlist = new GLib.GenericArray<string> ();
		paramlist.add (msg);
		used_test = true;
	}

}

public class Bar : Foo {

	public Bar (string text) throws Error {
		base (text, "bye");
	}

	public Bar.other (int num, ...) {
		try {
			base ("hey");
		} catch (Error e) {
		}
	}

}

void main () {
	Foo foo;

	foo = new Foo ("one", "two", "three");
	assert (!foo.used_test);
	assert (foo.paramlist.length == 3);
	assert (foo.paramlist[0] == "one");
	assert (foo.paramlist[1] == "two");
	assert (foo.paramlist[2] == "three");

	foo = new Foo.test ("meh");
	assert (foo.used_test);
	assert (foo.paramlist.length == 1);
	assert (foo.paramlist[0] == "meh");

	foo = new Bar ("hello");
	assert (!foo.used_test);
	assert (foo.paramlist.length == 2);
	assert (foo.paramlist[0] == "hello");
	assert (foo.paramlist[1] == "bye");

	foo = new Bar.other (1, 2, 3);
	assert (!foo.used_test);
	assert (foo.paramlist.length == 1);
	assert (foo.paramlist[0] == "hey");
}
