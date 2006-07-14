using GLib;

class Maman.Foo {
	public void run () {
		stdout.printf (" 2");
		
		var sa = "a,b,c,d".split (",");
		var i = 3;
		
		stdout.printf (" 3");
		
		if (sa[inc()] == "a") {
			stdout.printf (" 4");
		}
		if (sa[inc()] == "b") {
			stdout.printf (" 5");
		}
		if (sa[2] == "c") {
			stdout.printf (" 6");
		}
		if (sa[i] == "d") {
			stdout.printf (" 7");
		}

		stdout.printf (" 8");
	}
	
	public int inc () {
		return counter++;
	}

	static int main (int argc, string[] argv) {
		stdout.printf ("Element access: 1");
		
		var foo = new Foo ();
		foo.run ();
	
		stdout.printf (" 9\n");

		return 0;
	}
	
	private int counter = 0;
}
