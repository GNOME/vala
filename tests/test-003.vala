using GLib;

class Maman.Bar : Object {
}

class Maman.SubBar : Bar {
	static int main (string[] args) {
		stdout.printf ("Subtype Test\n");
		return 0;
	}
}
