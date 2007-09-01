using GLib;

public class Sample : Object {
	public Sample () {
	}

	public void run () {
		stdout.printf ("Hello, world!\n");
	}

	static int main (string[] args) {
		var sample = new Sample ();
		sample.run ();
		return 0;
	}
}

