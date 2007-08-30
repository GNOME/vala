using GLib;

class Maman.Bar : Object {
	public virtual void do_action () {
		stdout.printf (" BAD");
	}
}

class Maman.SubBar : Bar {
	public override void do_action () {
		stdout.printf (" 2");
	}

	static int main (string[] args) {
		stdout.printf ("Virtual Method Test: 1");

		Bar bar = new SubBar ();
		bar.do_action ();
	
		stdout.printf (" 3\n");

		return 0;
	}
}
