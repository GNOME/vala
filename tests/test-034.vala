using GLib;

class Maman.A : Object {
}

class Maman.B : A {
}

class Maman.C : Object {
}

class Maman.Bar : Object {
	static void main () {
		var a = new A ();
		var b = new B ();
		var c = new C ();

		stdout.printf ("init: %d %d %d\n", null != a, null != b, null != c);

		stdout.printf ("is A: %d %d %d\n", a is A, b is A, c is A);
		stdout.printf ("is B: %d %d %d\n", a is B, b is B, c is B);
		stdout.printf ("is C: %d %d %d\n", a is C, b is C, c is C);

		stdout.printf ("as A: %d %d %d\n", null != (a as A), null != (b as A), null != (c as A));
		stdout.printf ("as B: %d %d %d\n", null != (a as B), null != (b as B), null != (c as B));
		stdout.printf ("as C: %d %d %d\n", null != (a as C), null != (b as C), null != (c as C));
	}
}
