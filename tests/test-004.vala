using GLib;

class Maman.Bar : Object {
	public void do_action () {
		stdout.printf (" 2");
	}
}

class Maman.SubBar : Bar {
	static int main (string[] args) {
		stdout.printf ("Inheritance Test: 1");

		var bar = new SubBar ();
		bar.do_action ();
		
		stdout.printf (" 3\n");
	
		return 0;
	}
}
