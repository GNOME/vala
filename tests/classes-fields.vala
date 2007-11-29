using GLib;

class Maman.Foo : Object {
	public int public_base_field = 2;
}

class Maman.Bar : Foo {
	public int public_field = 3;
	private int private_field = 4;
	private static int private_static_field = 5;
	
	void do_action () {
		stdout.printf (" %d %d %d %d", public_base_field, public_field,
		               private_field, private_static_field);
		public_base_field = 6;
		public_field = 7;
		private_field = 8;
		private_static_field = 9;
		stdout.printf (" %d %d %d %d", public_base_field, public_field,
		               private_field, private_static_field);
	}

	static int main (string[] args) {
		stdout.printf ("Field Test: 1");
		
		var bar = new Bar ();
		bar.do_action ();
		
		stdout.printf (" 10\n");
		
		return 0;
	}
}
