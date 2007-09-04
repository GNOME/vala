using GLib;

class Maman.Bar : Object {
	static void main () {
		 // FIXME: figure out why "new string[]" is needed (again?)
		var tokens = new string[] { "Hello", "World", "this", "is", "Vala", "GNOME", null };
		var t4 = " 5";

		stdout.printf ("testing switch on strings:");

		foreach(weak string t in tokens) {
			switch (t) {
				case "Hello":
					stdout.printf (" 1");
					break;

				case "World":
					stdout.printf (" 2");
					break;

				case "this":
					stdout.printf (" 3");
					break;

				case ("is"):
					stdout.printf (" 4");
					break;

				case tokens[4]:
					stdout.printf (t4);
					tokens[4] = "GNOME";
					t4 = " 6";
					break;

				default:
					stdout.printf (" 7");
					break;
			}
		}

		tokens[4] = null; // FIXME: element access on array takes ownership

		stdout.printf ("\n");
	}
}

