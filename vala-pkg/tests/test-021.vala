using GLib;

class Maman.Foo {
	static int main (string[] args) {
		stdout.printf ("String + operator: 1");
		
		stdout.printf (" 2" + " 3");
		
		string s = " 4";
		s += " 5";
		
		stdout.printf ("%s", s);
	
		stdout.printf (" 6\n");

		return 0;
	}
}
