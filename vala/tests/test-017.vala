using GLib;

interface Maman.Ibaz {
	public abstract void do_action ();
}

class Maman.Baz : Ibaz {
	public override void do_action () {
		stdout.printf (" 2");
	}

	static int main (string[] args) {
		stdout.printf ("Interface Test: 1");

		Ibaz ibaz = new Baz ();
		ibaz.do_action ();
	
		stdout.printf (" 3\n");

		return 0;
	}
}
