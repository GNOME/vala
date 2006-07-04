using GLib;

class Maman.Bar {
	static int main (int argc, string[] argv) {
		stdout.printf ("Block Test: 1");
		
		{
			stdout.printf (" 2");
		}
		
		stdout.printf (" 3\n");
		
		return 0;
	}
}
