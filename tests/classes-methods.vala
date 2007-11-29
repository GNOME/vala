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

		return 0;
	}
}
