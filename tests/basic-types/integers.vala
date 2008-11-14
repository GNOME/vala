using GLib;

class Maman.Bar : Object {
	static void test_binary_expressions () {
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
	}

	static void test_assignments () {
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
		
		i = 12;
		i -= 1 - 2;
		stdout.printf (" %d", i);

		stdout.printf (" 14\n");
	}

	static void test_ranges () {
		stdout.printf (
			"int8: %s...%s\n",
			int8.MIN.to_string (), 
			int8.MAX.to_string ());
		stdout.printf (
			"int16: %s...%s\n",
			int16.MIN.to_string (),
			int16.MAX.to_string ());
		stdout.printf (
			"int32: %s...%s\n",
			int32.MIN.to_string (),
			int32.MAX.to_string ());
		stdout.printf (
			"int64: %s...%s\n",
			int64.MIN.to_string (),
			int64.MAX.to_string ());

		stdout.printf (
			"uint8: %s...%s\n",
			uint8.MIN.to_string (),
			uint8.MAX.to_string ());
		stdout.printf (
			"uint16: %s...%s\n",
			uint16.MIN.to_string (),
			uint16.MAX.to_string ());
		stdout.printf (
			"uint32: %s...%s\n",
			uint32.MIN.to_string (),
			uint32.MAX.to_string ());
		stdout.printf (
			"uint64: %s...%s\n",
			uint64.MIN.to_string (),
			uint64.MAX.to_string ());
	}

	static int main (string[] args) {
		test_binary_expressions ();

		test_assignments ();

		test_ranges ();

		return 0;
	}
}
