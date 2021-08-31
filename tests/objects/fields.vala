[Compact]
class CompactFoo {
	public int initialized_field = 23;
	private static int private_static_field = 42;
	public static int public_static_field = 4711;
}

class Foo {
	public int public_base_field = 23;
	public class int public_base_class_field = 42;
}

class Faz : Foo {
	public int public_field = 23;
	private int private_field = 23;

	public class int public_class_field = 42;
	private class int private_class_field = 42;

	public static int public_static_field = 4711;
	private static int private_static_field = 4711;

	class construct {
		//FIXME
		public_class_field = 42;
		assert (public_class_field == 42);
		public_class_field = 24;
		assert (public_class_field == 24);

		//FIXME
		private_class_field = 42;
		assert (private_class_field == 42);
		private_class_field = 24;
		assert (private_class_field == 24);

		assert (public_base_class_field == 42);
		public_base_class_field = 24;
		assert (public_base_class_field == 24);
		public_base_class_field = 42;
	}

	static construct {
		assert (public_class_field == 42);
		public_class_field = 24;
		assert (public_class_field == 24);

		assert (private_class_field == 42);
		private_class_field = 24;
		assert (private_class_field == 24);

		assert (public_base_class_field == 42);
		public_base_class_field = 24;
		assert (public_base_class_field == 24);
		public_base_class_field = 42;
	}

	public void action () {
		assert (public_field == 23);
		public_field = 32;
		assert (public_field == 32);

		assert (private_field == 23);
		private_field = 32;
		assert (private_field == 32);

		assert (public_base_field == 23);
		public_base_field = 32;
		assert (public_base_field == 32);
	}

	public void action_class () {
		assert (public_class_field == 24);
		public_class_field = 42;
		assert (public_class_field == 42);

		assert (private_class_field == 24);
		private_class_field = 42;
		assert (private_class_field == 42);

		assert (public_base_class_field == 42);
		public_base_class_field = 24;
		assert (public_base_class_field == 24);
	}

	public void lock_action () {
		lock (private_static_field) {
			private_static_field = 1147;
			assert (private_static_field == 1147);
		}
		lock (public_static_field) {
			public_static_field = 1147;
			assert (public_static_field == 1147);
		}
		lock (private_field) {
			private_field = 1147;
			assert (private_field == 1147);
		}
		lock (public_field) {
			public_field = 1147;
			assert (public_field == 1147);
		}
	}

	public void lock_action_class () {
		lock (private_class_field) {
			private_class_field = 1147;
			assert (private_class_field == 1147);
		}
		lock (public_class_field) {
			public_class_field = 1147;
			assert (public_class_field == 1147);
		}
	}
}

class Bar : Object {
	public int public_base_field = 23;
	public class int public_base_class_field = 42;
}

class Baz : Bar {
	public int public_field = 23;
	private int private_field = 23;

	public class int public_class_field = 42;
	private class int private_class_field = 42;

	public static int public_static_field = 4711;
	private static int private_static_field = 4711;

	class construct {
		//FIXME
		print ("%i\n", public_class_field);
		public_class_field = 42;
		assert (public_class_field == 42);
		public_class_field = 24;
		assert (public_class_field == 24);

		//FIXME
		print ("%i\n", private_class_field);
		private_class_field = 42;
		assert (private_class_field == 42);
		private_class_field = 24;
		assert (private_class_field == 24);

		assert (public_base_class_field == 42);
		public_base_class_field = 24;
		assert (public_base_class_field == 24);
		public_base_class_field = 42;
	}

	static construct {
		assert (public_class_field == 42);
		public_class_field = 24;
		assert (public_class_field == 24);

		assert (private_class_field == 42);
		private_class_field = 24;
		assert (private_class_field == 24);

		assert (public_base_class_field == 42);
		public_base_class_field = 24;
		assert (public_base_class_field == 24);
		public_base_class_field = 42;
	}

	public void action () {
		assert (public_field == 23);
		public_field = 32;
		assert (public_field == 32);

		assert (private_field == 23);
		private_field = 32;
		assert (private_field == 32);

		assert (public_base_field == 23);
		public_base_field = 32;
		assert (public_base_field == 32);
	}

	public void action_class () {
		assert (public_class_field == 24);
		public_class_field = 42;
		assert (public_class_field == 42);

		assert (private_class_field == 24);
		private_class_field = 42;
		assert (private_class_field == 42);

		assert (public_base_class_field == 42);
		public_base_class_field = 24;
		assert (public_base_class_field == 24);
	}

	public void lock_action () {
		lock (private_static_field) {
			private_static_field = 1147;
			assert (private_static_field == 1147);
		}
		lock (public_static_field) {
			public_static_field = 1147;
			assert (public_static_field == 1147);
		}
		lock (private_field) {
			private_field = 1147;
			assert (private_field == 1147);
		}
		lock (public_field) {
			public_field = 1147;
			assert (public_field == 1147);
		}
	}

	public void lock_action_class () {
		lock (private_class_field) {
			private_class_field = 1147;
			assert (private_class_field == 1147);
		}
		lock (public_class_field) {
			public_class_field = 1147;
			assert (public_class_field == 1147);
		}
	}
}

class Manam<T> {
	public T foo;
}

void main () {
	{
		var foo = new Foo ();
		foo.public_base_field = 132;
		assert (foo.public_base_field == 132);
		foo.public_base_class_field = 264;
		assert (foo.public_base_class_field == 264);
		foo.public_base_class_field = 42;
	}
	{
		var faz = new Faz ();
		faz.action ();
		faz.action_class ();
		faz.lock_action ();
		faz.lock_action_class ();

		faz.public_field = 66;
		assert (faz.public_field == 66);
		faz.public_class_field = 132;
		assert (faz.public_class_field == 132);
		faz.public_base_class_field = 264;
		assert (faz.public_base_class_field == 264);
	}
	{
		var bar = new Bar ();
		bar.public_base_field = 132;
		assert (bar.public_base_field == 132);
		bar.public_base_class_field = 264;
		assert (bar.public_base_class_field == 264);
		bar.public_base_class_field = 42;
	}
	{
		var baz = new Baz ();
		baz.action ();
		baz.action_class ();
		baz.lock_action ();
		baz.lock_action_class ();

		baz.public_field = 66;
		assert (baz.public_field == 66);
		baz.public_class_field = 132;
		assert (baz.public_class_field == 132);
		baz.public_base_class_field = 264;
		assert (baz.public_base_class_field == 264);
	}
	{
		var foo = new CompactFoo ();
		assert (foo.initialized_field == 23);
		assert (foo.public_static_field == 4711);
	}
	{
		var manam = new Manam<Bar> ();
		manam.foo = null;
	}
}
