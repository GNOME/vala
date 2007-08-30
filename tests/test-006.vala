using GLib;

class Maman.Bar : Object {
	static int main (string[] args) {
		stdout.printf ("For Test: 1");

		int i;
		for (i = 2; i < 7; i++) {
			stdout.printf (" %d", i);
		}
		
		stdout.printf (" 7\n");

		return 0;
	}
}
