using GLib;

public static delegate void Maman.VoidCallback ();

public static delegate int Maman.ActionCallback ();

public delegate void Maman.InstanceCallback (int i);

class Maman.Bar : Object {
	public Bar () {
	}

	static void do_void_action () {
		stdout.printf (" 2");
	}

	static int do_action () {
		return 4;
	}

	void do_instance_action (int i) {
		assert (i == 42);

		stdout.printf (" 6");
	}

	static void call_instance_delegate (InstanceCallback instance_cb) {
		instance_cb (42);
	}

	static int main (string[] args) {
		stdout.printf ("Delegate Test: 1");
		
		VoidCallback void_cb = do_void_action;

		void_cb ();

		stdout.printf (" 3");

		ActionCallback cb = do_action;
		
		stdout.printf (" %d", cb ());

		stdout.printf (" 5");

		var bar = new Bar ();

		InstanceCallback instance_cb = bar.do_instance_action;
		call_instance_delegate (instance_cb);

		stdout.printf (" 7\n");

		return 0;
	}
}
