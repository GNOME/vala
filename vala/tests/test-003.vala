using GLib;

class Maman.Bar {
}

class Maman.SubBar : Bar {
	static int main (int argc, string[] argv) {
		stdout.printf ("Subtype Test\n");
		return 0;
	}
}
