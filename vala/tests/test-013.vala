using GLib;

class Maman.Bar {
	static int main (int argc, string[] argv) {
		stdout.printf ("Break Test: 1");
		
		int i;
		for (i = 0; i < 10; i++) {
			stdout.printf (" 2");
			break;
		}
		
		stdout.printf (" 3\n");
		
		return 0;
	}
}
