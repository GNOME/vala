using GLib;

class Maman.Bar {
	public static void do_action () {
		stdout.printf (" 2");
	}
}

class Maman.SubBar : Bar {
	static int main (int argc, string[] argv) {
		stdout.printf ("Static Inheritance Test: 1");

		do_action ();
		
		stdout.printf (" 3\n");
	
		return 0;
	}
}
