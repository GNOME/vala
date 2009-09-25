using GLib;

class Maman.A : Object {
}

class Maman.B : A {
}

class Maman.C : Object {
}

class Maman.Bar : Object {
	public static void main () {
		var a = new A ();
		var b = new B ();
		var c = new C ();

		stdout.printf ("init: %d %d %d\n", null != a ? 1 : 0, null != b ? 1 : 0, null != c ? 1 : 0);

		stdout.printf ("is A: %d %d %d\n", (a is A) ? 1 : 0, (b is A) ? 1 : 0, (c is A) ? 1 : 0);
		stdout.printf ("is B: %d %d %d\n", (a is B) ? 1 : 0, (b is B) ? 1 : 0, (c is B) ? 1 : 0);
		stdout.printf ("is C: %d %d %d\n", (a is C) ? 1 : 0, (b is C) ? 1 : 0, (c is C) ? 1 : 0);

		stdout.printf ("as A: %d %d %d\n", null != (a as A) ? 1 : 0, null != (b as A) ? 1 : 0, null != (c as A) ? 1 : 0);
		stdout.printf ("as B: %d %d %d\n", null != (a as B) ? 1 : 0, null != (b as B) ? 1 : 0, null != (c as B) ? 1 : 0);
		stdout.printf ("as C: %d %d %d\n", null != (a as C) ? 1 : 0, null != (b as C) ? 1 : 0, null != (c as C) ? 1 : 0);
	}
}

void main () {
	Maman.Bar.main ();
}

