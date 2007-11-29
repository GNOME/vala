using GLib;

interface Maman.Ibaz : Object {
	public abstract void do_action ();
}

class Maman.Baz : Object, Ibaz {
	public void do_action () {
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
