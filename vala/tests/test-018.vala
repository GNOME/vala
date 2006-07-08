using GLib;

class Maman.Foo {
	public signal void activated (bool b);

	public void do_action () {
		activated (false);
	}
}

class Maman.Bar {
	void activated (Foo foo, bool b) {
		if (b) {
			stdout.printf (" BAD");
		} else {
			stdout.printf (" 5");
		}
	}

	public void run () {
		stdout.printf (" 2");
		
		var foo = new Foo ();
		
		foo.activated += (foo, b) => {
			if (b) {
				stdout.printf (" BAD");
			} else {
				stdout.printf (" 4");
			}
		};

		foo.activated += activated;

		stdout.printf (" 3");
		
		foo.do_action ();

		stdout.printf (" 6");
	}

	static int main (int argc, string[] argv) {
		stdout.printf ("Signal Test: 1");
		
		var bar = new Bar ();
		bar.run ();
	
		stdout.printf (" 7\n");

		return 0;
	}
}
