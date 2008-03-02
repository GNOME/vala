using GLib;

class Maman.Bar : Object {
	public void do_action () {
		stdout.printf (" 2");
	}

	public static void do_static_action () {
		stdout.printf (" 2");
	}

	public virtual void do_virtual_action () {
		stdout.printf (" BAD");
	}
}

class Maman.SubBar : Bar {
	public override void do_virtual_action () {
		stdout.printf (" 2");
	}

	static void accept_ref_string (ref string str) {
	}

	static void test_classes_methods_ref_parameters () {
		string str = "hello";
		accept_ref_string (ref str);
	}

	static int main (string[] args) {
		stdout.printf ("Inheritance Test: 1");

		var bar = new SubBar ();
		bar.do_action ();
		
		stdout.printf (" 3\n");

		stdout.printf ("Static Inheritance Test: 1");

		do_static_action ();

		stdout.printf (" 3\n");

		stdout.printf ("Virtual Method Test: 1");

		bar.do_virtual_action ();
	
		stdout.printf (" 3\n");

		// test symbol resolving to check that methods of implemented
		// interfaces take precedence of methods in base classes
		stdout.printf ("Interface Inheritance Test: 1");

		var foobar = new SubFooBar ();
		foobar.do_action ();
	
		stdout.printf (" 3\n");

		test_classes_methods_ref_parameters ();

		return 0;
	}
}

interface Maman.Foo {
	public void do_action () {
		stdout.printf (" 2");
	}
}

class Maman.FooBar : Object {
	public void do_action () {
		stdout.printf (" BAD");
	}
}

class Maman.SubFooBar : FooBar, Foo {
}

