using GLib;

class Maman.Bar {
	static int main (int argc, string[] argv) {
		stdout.printf ("Conditional Expression Test: 1");
		
		stdout.printf (" %d", false ? -1 : 2);
		
		stdout.printf (" 3\n");
		
		return 0;
	}
}
