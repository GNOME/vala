using GLib;

class Maman.Bar : Object {
	public static int main () {
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

void main () {
	Maman.Bar.main ();
}
