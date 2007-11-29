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

		stdout.printf ("User Signal Test: 1");

		var user_bar = new UserBar ();
		user_bar.run ();

		stdout.printf (" 6\n");

		return 0;
	}
}

class Maman.UserFoo : Object {
	public signal void activated (int i1, int i2);

	public void do_action () {
		activated (6, -2);
	}
}

class Maman.UserBar : Object {
	public void run () {
		stdout.printf (" 2");
		
		var foo = new UserFoo ();
		
		foo.activated += (foo, i1, i2) => {
			stdout.printf (" %d", i1 + i2);
		};

		stdout.printf (" 3");
		
		foo.do_action ();

		stdout.printf (" 5");
	}
}

