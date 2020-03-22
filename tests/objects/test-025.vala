using GLib;

class Maman.Bar : Object {
	public virtual void do_action () {
		stdout.printf (" 3");
	}
}

class Maman.SubBar : Bar {
	public override void do_action () {
		stdout.printf (" BAD");
	}

	public void run () {
		stdout.printf (" 2");

		base.do_action ();

		stdout.printf (" 4");
	}

	public static int main () {
		stdout.printf ("Base Access Test: 1");

		var bar = new SubBar ();
		bar.run ();

		stdout.printf (" 5\n");

		return 0;
	}
}
