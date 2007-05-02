using GLib;

class Maman.Foo {
	public signal void activated (int i1, int i2);

	public void do_action () {
		activated (6, -2);
	}
}

class Maman.Bar {
	public void run () {
		stdout.printf (" 2");
		
		var foo = new Foo ();
		
		foo.activated += (foo, i1, i2) => {
			stdout.printf (" %d", i1 + i2);
		};

		stdout.printf (" 3");
		
		foo.do_action ();

		stdout.printf (" 5");
	}

	static int main (string[] args) {
		stdout.printf ("User Signal Test: 1");
		
		var bar = new Bar ();
		bar.run ();
	
		stdout.printf (" 6\n");

		return 0;
	}
}
