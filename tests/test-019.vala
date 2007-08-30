using GLib;

class Maman.Foo : Object {
	public void run () {
		stdout.printf (" 2");
		
		var sa = "a,b,c,d".split (",");
		int i = 3;
		
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

		string bar = "efgh";
		counter = 0;
		if (bar[inc()] == 'e') {
			stdout.printf (" 8");
		}
		if (bar[inc()] == 'f') {
			stdout.printf (" 9");
		}
		if (bar[2] == 'g') {
			stdout.printf (" 10");
		}
		if (bar[i] == 'h') {
			stdout.printf (" 11");
		}


		stdout.printf (" 12");
	}
	
	public int inc () {
		return counter++;
	}

	static int main (string[] args) {
		stdout.printf ("Element access: 1");
		
		var foo = new Foo ();
		foo.run ();
	
		stdout.printf (" 13\n");

		return 0;
	}
	
	private int counter = 0;
}
