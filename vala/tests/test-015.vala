using GLib;

callback int Maman.ActionCallback (int i);

class Maman.Bar {
	static int do_action (ActionCallback cb) {
		return cb (1);
	}

	static int main (int argc, string[] argv) {
		stdout.printf ("Lambda Test: 1");
		
		stdout.printf (" %d", do_action (i => i * 2));
		
		stdout.printf (" 3\n");
		
		return 0;
	}
}
