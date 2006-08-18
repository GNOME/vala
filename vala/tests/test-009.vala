using GLib;

class Maman.Foo {
	private int _public_base_property = 2;
	public int public_base_property {
		get {
			return _public_base_property;
		}
		set {
			_public_base_property = value;
		}
	}
}

class Maman.Bar : Foo {
	private int _public_property = 3;
	public int public_property {
		get {
			return _public_property;
		}
		set {
			_public_property = value;
		}
	}
	
	void do_action () {
		stdout.printf (" %d %d", public_base_property, public_property);
		public_base_property = 4;
		public_property = 5;
		stdout.printf (" %d %d", public_base_property, public_property);
	}

	static int main (string[] args) {
		stdout.printf ("Property Test: 1");
		
		var bar = new Bar ();
		bar.do_action ();
		
		stdout.printf (" 6\n");
		
		return 0;
	}
}
