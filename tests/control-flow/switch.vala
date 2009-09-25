using GLib;

class Maman.Bar : Object {
	static bool test_switch_control_flow_graph () {
		int a = 0;
		switch (a) {
		case 1:
			return false;
		default:
			return true;
		}
	}

	public static int main () {
		stdout.printf ("For Test: 1");

		int i;
		for (i = 2; i < 7; i++) {
			stdout.printf (" %d", i);
		}
		
		stdout.printf (" 7\n");

		stdout.printf ("Switch statement: 1");

		var foo = new Foo ();
		foo.run ();

		stdout.printf (" 7\n");

		test_switch_control_flow_graph ();

		return 0;
	}
}

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
	
	private int counter = 0;
}


void main () {
	Maman.Bar.main ();
}

