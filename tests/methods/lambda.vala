using GLib;

static delegate int Maman.ActionCallback (int i);

class Maman.Bar : Object {
	static int do_action (ActionCallback cb) {
		return cb (1);
	}

	public static int main () {
		stdout.printf ("Lambda Test: 1");
		
		stdout.printf (" %d", do_action (i => i * 2));
		
		stdout.printf (" %d", do_action (i => { return i * 3; }));
		
		stdout.printf (" 4\n");
		
		return 0;
	}
}

void main () {
	Maman.Bar.main ();
}

