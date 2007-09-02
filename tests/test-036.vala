using GLib;

class Maman.Bar : GLib.Object {
	static void main () {
		stdout.printf ("testing function pointers:");
		var table = new HashTable<string, Bar>.full (str_hash, str_equal, g_free, Object.unref);
		stdout.printf (" 1");

		table.insert ("foo", new Bar ());
		stdout.printf (" 2");

		var bar = table.lookup ("foo");
		stdout.printf (" 3\n");
	}
}
