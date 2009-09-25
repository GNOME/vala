using GLib;

interface Maman.Ibaz : Object {
	public abstract void do_action ();

	public abstract void do_virtual_action ();
}

class Maman.Baz : Object, Ibaz {
	public void do_action () {
		stdout.printf (" 2");
	}

	public virtual void do_virtual_action () {
		stdout.printf (" 4");
	}
}

class Maman.SubBaz : Baz {
	public override void do_virtual_action () {
		stdout.printf (" 6");
	}

	public static int main () {
		stdout.printf ("Interface Test: 1");

		Ibaz ibaz = new Baz ();
		ibaz.do_action ();
	
		stdout.printf (" 3");

		ibaz.do_virtual_action ();

		stdout.printf (" 5");

		Ibaz subbaz = new SubBaz ();
		subbaz.do_virtual_action ();

		stdout.printf (" 7\n");

		return 0;
	}
}

void main () {
	Maman.SubBaz.main ();
}

