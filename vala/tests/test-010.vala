using GLib;

class Maman.Bar {
	static int main (string[] args) {
		stdout.printf ("Assignment Test: 1");
		
		int i;
		
		i = 2;
		stdout.printf (" %d", i);
		
		i |= 1;
		stdout.printf (" %d", i);
		
		i = 5;
		i &= 6;
		stdout.printf (" %d", i);
		
		i ^= 1;
		stdout.printf (" %d", i);
		
		i += 1;
		stdout.printf (" %d", i);
		
		i -= -1;
		stdout.printf (" %d", i);
		
		i = 2;
		i *= 4;
		stdout.printf (" %d", i);
		
		i = 18;
		i /= 2;
		stdout.printf (" %d", i);
		
		i = 21;
		i %= 11;
		stdout.printf (" %d", i);
		
		i = 6;
		i <<= 1;
		stdout.printf (" %d", i - 1);
		
		i = 25;
		i >>= 1;
		stdout.printf (" %d", i);
		
		stdout.printf (" 13\n");
		
		return 0;
	}
}
