using GLib;

class Maman.Foo : Object {
	public int public_base_field = 2;
}

class Maman.Bar : Foo {
	public int public_field = 3;
	private int private_field = 4;
	private static int private_static_field = 5;
	public static int public_static_field = 6;
	
	void do_action () {
		stdout.printf (" %d %d %d %d %d", public_base_field, public_field,
		               private_field, private_static_field, public_static_field);
		public_base_field = 7;
		public_field = 8;
		private_field = 9;
		private_static_field = 10;
		public_static_field = 11;
		stdout.printf (" %d %d %d %d %d", public_base_field, public_field,
		               private_field, private_static_field, public_static_field);
	}

	static int main (string[] args) {
		stdout.printf ("Field Test: 1");
		
		var bar = new Bar ();
		bar.do_action ();
		
		stdout.printf (" 12\n");
		
		return 0;
	}
}
