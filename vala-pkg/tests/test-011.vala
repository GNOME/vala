using GLib;

class Maman.Bar {
	static int main (string[] args) {
		stdout.printf ("Binary Expression Test: 1");
		
		stdout.printf (" %d", 1 + 1);
		
		stdout.printf (" %d", 4 - 1);
		
		stdout.printf (" %d", 2 * 2);
		
		stdout.printf (" %d", 10 / 2);
		
		stdout.printf (" %d", 13 % 7);
		
		stdout.printf (" %d", (4 << 1) - 1);
		
		stdout.printf (" %d", 16 >> 1);
		
		if (1 < 2) {
			stdout.printf (" 9");
		} else {
			stdout.printf (" BAD");
		}
		
		if (1 > 2) {
			stdout.printf (" BAD");
		} else {
			stdout.printf (" 10");
		}
		
		if (1 <= 2) {
			stdout.printf (" 11");
		} else {
			stdout.printf (" BAD");
		}
		
		if (1 >= 2) {
			stdout.printf (" BAD");
		} else {
			stdout.printf (" 12");
		}
		
		if (1 == 1) {
			stdout.printf (" 13");
		} else {
			stdout.printf (" BAD");
		}
		
		if (1 != 1) {
			stdout.printf (" BAD");
		} else {
			stdout.printf (" 14");
		}
		
		stdout.printf (" %d", 31 & 47);
		
		stdout.printf (" %d", 0 | 16);
		
		stdout.printf (" %d", 16 ^ 1);
		
		if (true && false) {
			stdout.printf (" BAD");
		} else {
			stdout.printf (" 18");
		}
		
		if (true || false) {
			stdout.printf (" 19");
		} else {
			stdout.printf (" BAD");
		}
		
		stdout.printf (" 20\n");
		
		return 0;
	}
}
