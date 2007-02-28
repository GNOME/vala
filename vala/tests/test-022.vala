using GLib;

class Maman.Foo {
	static int main (string[] args) {
		stdout.printf ("One dimensional array creation and assignment: 1");
		
		var a = new int[4] {1,2};
		
		stdout.printf (" 2");
		
		a[2] = 3;
		
		stdout.printf (" 3");
		
		a[3] = 4;
		
		stdout.printf (" 4");
		
		if (a[0] == 1) {
			stdout.printf (" 5");
		}
		if (a[1] == 2) {
			stdout.printf (" 6");
		}
		if (a[2] == 3) {
			stdout.printf (" 7");
		}
		if (a[3] == 4) {
			stdout.printf (" 8");
		}
		if (a.length == 4) {
			stdout.printf (" 9");
		}
		a.resize (10);
		stdout.printf (" %d", a.length);
	
		stdout.printf (" 11\n");

		return 0;
	}
}
