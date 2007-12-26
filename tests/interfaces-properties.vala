using GLib;

interface Maman.Ibaz : Object {
	public abstract int number { get; }

	public void simple_method () {
		int n = number;
		stdout.printf (" %d", n);
	}
}

class Maman.Baz : Object, Ibaz {
	public int number {
		get { return 2; }
	}
}

class Maman.SubBaz : Baz {
	static int main (string[] args) {
		stdout.printf ("Interface Properties Test: 1");

		Ibaz ibaz = new Baz ();
		ibaz.simple_method ();
	
		stdout.printf (" 3\n");

		return 0;
	}
}
