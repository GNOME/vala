using GLib;

namespace Maman {
	static int main (string[] args) {
		stdout.printf ("Namespace Test\n");

		Bar.run ();

		return 0;
	}

	class Bar : Object {
		public static void run () {
			stdout.printf ("Class in Namespace Test\n");
		}
	}
}

