using GLib;

class Maman.Bar : Object {
	static int main (string[] args) {
		stdout.printf ("Block Test: 1");
		
		{
			stdout.printf (" 2");
		}
		
		stdout.printf (" 3\n");
		
		return 0;
	}
}
