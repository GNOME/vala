using GLib;

class Maman.Foo : Object {
	public signal void activated (bool b);

	public void do_action (bool b) {
		activated (b);
	}
}

class Maman.Bar : Object {
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
				stdout.printf (" 8");
			} else {
				stdout.printf (" 4");
			}
		};

		foo.activated += activated;

		stdout.printf (" 3");
		
		foo.do_action (false);

		stdout.printf (" 6");
		
		foo.activated -= activated;

		stdout.printf (" 7");

		foo.do_action (true);

		stdout.printf (" 9");
	}

	static int main (string[] args) {
		stdout.printf ("Signal Test: 1");
		
		var bar = new Bar ();
		bar.run ();
	
		stdout.printf (" 10\n");

		return 0;
	}
}
