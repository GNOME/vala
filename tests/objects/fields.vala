using GLib;

[Compact]
class CompactTest {
	public int initialized_field = 24;
	private static int private_static_field = 25;
	public static int public_static_field = 26;
}

class Maman.Foo : Object {
	public int public_base_field = 2;
	public class int public_class_field = 23;
}

class Maman.Bar : Foo {
	public int public_field = 3;
	private int private_field = 4;
	private static int private_static_field = 5;
	public static int public_static_field = 6;
	private class int private_class_field;
	public class int public_class_field;

	class construct {
		private_class_field = 7;
	}
	static construct {
		public_class_field = 8;
	}

	void do_action () {
		stdout.printf (" %d %d %d %d %d %d %d", public_base_field, public_field,
		               private_field, private_static_field, public_static_field,
					   private_class_field, public_class_field);
		public_base_field = 9;
		public_field = 10;
		private_field = 11;
		lock (private_static_field) {
			private_static_field = 12;
		}
		lock (public_static_field) {
			public_static_field = 13;
		}
		lock (private_class_field) {
			private_class_field = 14;
		}
		lock (public_class_field) {
			public_class_field = 15;
		}
		stdout.printf (" %d %d %d %d %d %d %d", public_base_field, public_field,
		               private_field, private_static_field, public_static_field,
					   private_class_field, public_class_field);
	}

	class void do_action_class () {
		stdout.printf (" %d %d %d %d", private_static_field, public_static_field,
					   private_class_field, public_class_field);
		lock (private_static_field) {
			private_static_field = 12;
		}
		lock (public_static_field) {
			public_static_field = 13;
		}
		lock (private_class_field) {
			private_class_field = 14;
		}
		lock (public_class_field) {
			public_class_field = 15;
		}
		stdout.printf (" %d %d %d %d", private_static_field, public_static_field,
					   private_class_field, public_class_field);
	}

	public static void run () {
		stdout.printf ("Field Test: 1");

		var bar = new Bar ();
		bar.do_action ();
		bar.do_action_class ();

		bar.public_base_field = 16;
		bar.public_field = 17;
		bar.private_field = 18;
		bar.private_static_field = 19;
		bar.public_static_field = 20;
		bar.private_class_field = 21;
		((Foo)bar).public_class_field = 22;
		stdout.printf (" %d %d %d %d %d %d %d", bar.public_base_field, bar.public_field,
		               bar.private_field, bar.private_static_field, bar.public_static_field,
					   bar.private_class_field, ((Foo)bar).public_class_field);

		var foo = new Foo ();
		stdout.printf (" %d", foo.public_class_field);

		var compact = new CompactTest ();
		stdout.printf (" %d", compact.initialized_field);

		stdout.printf (" 27\n");
	}
}

class Maman.Baz<T> {
	public T foo;
}

void main () {
	Maman.Bar.run ();
	Maman.Baz<Maman.Bar> baz = new Maman.Baz<Maman.Bar> ();
	baz.foo = null;
}
