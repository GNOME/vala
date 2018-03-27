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

		foo.activated.connect ((foo, b) => {
			if (b) {
				stdout.printf (" 8");
			} else {
				stdout.printf (" 4");
			}
		});

		foo.activated.connect (activated);

		stdout.printf (" 3");

		foo.do_action (false);

		stdout.printf (" 6");

		foo.activated.disconnect (activated);

		stdout.printf (" 7");

		foo.do_action (true);

		stdout.printf (" 9");
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

		foo.activated.connect ((foo, i1, i2) => {
			stdout.printf (" %d", i1 + i2);
		});

		stdout.printf (" 3");

		foo.do_action ();

		stdout.printf (" 5");
	}
}

class Maman.ReturnFoo : Object {
	public signal int int_activated (int arg);
	public signal string string_activated (string arg);
}

class Maman.ReturnBar : Object {
	public void run () {
		stdout.printf (" 2");

		var foo = new ReturnFoo ();

		foo.int_activated.connect ((foo, arg) => {
			stdout.printf (" %d", arg);
			return arg + 1;
		});

		foo.string_activated.connect ((foo, arg) => {
			stdout.printf (arg);
			return " 6";
		});

		stdout.printf (" %d", foo.int_activated (3));

		stdout.printf (foo.string_activated (" 5"));

		stdout.printf (" 7");
	}
}

void main () {
	stdout.printf ("Signal Test: 1");

	var bar = new Maman.Bar ();
	bar.run ();

	stdout.printf (" 10\n");

	stdout.printf ("User Signal Test: 1");

	var user_bar = new Maman.UserBar ();
	user_bar.run ();

	stdout.printf (" 6\n");

	stdout.printf ("Signal Return Test: 1");

	var return_bar = new Maman.ReturnBar ();
	return_bar.run ();

	stdout.printf (" 8\n");
}

