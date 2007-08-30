using GLib;

class Maman.Foo : Object {
	public void run () {
		stdout.printf (" 2");
		
		switch (23) {
		case 23:
			stdout.printf (" 3");
			break;
		default:
			stdout.printf (" BAD");
			break;
		}
		
		switch (inc ()) {
		case 0:
			stdout.printf (" 4");
			break;
		case 1:
			stdout.printf (" BAD");
			break;
		default:
			stdout.printf (" BAD");
			break;
		}
		
		switch (42) {
		case 0:
			stdout.printf (" BAD");
			break;
		default:
			stdout.printf (" 5");
			break;
		case 1:
			stdout.printf (" BAD");
			break;
		}
		
		stdout.printf (" 6");
	}
	
	public int inc () {
		return counter++;
	}

	static int main (string[] args) {
		stdout.printf ("Switch statement: 1");
		
		var foo = new Foo ();
		foo.run ();
	
		stdout.printf (" 7\n");

		return 0;
	}
	
	private int counter = 0;
}
