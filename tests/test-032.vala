using GLib;

class Maman.Bar : Object {
	public int[] foo_numbers () {
		return new int[3] { 2, 3, 4 };
	}

	public void run () {
		foreach (int i in foo_numbers ()) {
			stdout.printf (" %d", i);
		}
	}

	static int main (string[] args) {
		stdout.printf ("Array Test: 1");
		
		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 5\n");
		
		return 0;
	}
}
