using GLib;

public class Sample : Object {
	private string automatic { get; set; }

	private string _name;
	public string name {
		get { return _name; }
		set { _name = value; }
	}

	private string _read_only;
	public string read_only {
		get { return _read_only; }
	}

	public Sample (string name) {
		this.name = name;
	}

	construct {
		_automatic = "InitialAutomatic";
		_read_only = "InitialReadOnly";
	}

	public void run() {
		notify += (s, p) => {
			stdout.printf("property `%s' has changed!\n",
				      p.name);
		};


		automatic = "TheNewAutomatic";
		name = "TheNewName";

		// The following statement would be rejected
		// read_only = "TheNewReadOnly";

		stdout.printf("automatic: %s\n", automatic);
		stdout.printf("name: %s\n", name);
		stdout.printf("read_only: %s\n", read_only);
		stdout.printf("automatic: %s\n", automatic);
        }

	static int main (string[] args) {
		var test = new Sample("InitialName");

		test.run();

		Maman.Bar.run ();

		return 0;
	}
}

abstract class Maman.Foo : Object {
	private int _public_base_property = 2;
	public int public_base_property {
		get {
			return _public_base_property;
		}
		set {
			_public_base_property = value;
		}
	}
	public abstract int abstract_base_property { get; set; }
}

class Maman.Bar : Foo {
	public int public_property { get; set; default = 3; }
	public override int abstract_base_property { get; set; }

	void do_action () {
		stdout.printf (" %d %d", public_base_property, public_property);
		public_base_property = 4;
		public_property = 5;
		stdout.printf (" %d %d", public_base_property, public_property);
	}

	public static void run () {
		stdout.printf ("Property Test: 1");
		
		var bar = new Bar ();
		bar.do_action ();
		
		Foo foo = bar;
		foo.abstract_base_property = 6;
		stdout.printf (" %d", foo.abstract_base_property);

		stdout.printf (" 7\n");
	}
}

