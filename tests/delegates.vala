using GLib;

public static delegate void Maman.VoidCallback ();

public static delegate int Maman.ActionCallback ();

class Maman.Bar : Object {
	static void do_void_action () {
		stdout.printf (" 2");
	}

	static int do_action () {
		return 4;
	}

	static int main (string[] args) {
		stdout.printf ("Delegate Test: 1");
		
		VoidCallback void_cb = do_void_action;

		void_cb ();

		stdout.printf (" 3");

		ActionCallback cb = do_action;
		
		stdout.printf (" %d", cb ());
		
		stdout.printf (" 5\n");
		
		return 0;
	}
}
