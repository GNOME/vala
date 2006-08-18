using GLib;

class Maman.Bar {
}

class Maman.SubBar : Bar {
	static int main (string[] args) {
		stdout.printf ("Subtype Test\n");
		return 0;
	}
}
