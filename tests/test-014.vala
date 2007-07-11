using GLib;

public static delegate int Maman.ActionCallback ();

class Maman.Bar {
	static int do_action () {
		return 2;
	}

	static int main (string[] args) {
		stdout.printf ("Delegate Test: 1");
		
		ActionCallback cb = do_action;
		
		stdout.printf (" %d", cb ());
		
		stdout.printf (" 3\n");
		
		return 0;
	}
}
