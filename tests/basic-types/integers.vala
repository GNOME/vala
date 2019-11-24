int static_negative_int = -1;

void test_int () {
	// declaration and initialization
	int i = 42;
	assert (i == 42);

	// assignment
	i = 23;
	assert (i == 23);

	// access
	int j = i;
	assert (j == 23);

	// +
	i = 42 + 23;
	assert (i == 65);
	i += 7;
	assert (i == 72);

	// -
	i = 42 - 23;
	assert (i == 19);
	i -= 7;
	assert (i == 12);

	// *
	i = 42 * 23;
	assert (i == 966);
	i *= 7;
	assert (i == 6762);

	// /
	i = 42 / 23;
	assert (i == 1);
	i /= 1;
	assert (i == 1);

	// %
	i = 42 % 23;
	assert (i == 19);
	i %= 7;
	assert (i == 5);

	// <<
	i = 42 << 3;
	assert (i == 336);
	i <<= 7;
	assert (i == 43008);

	// >>
	i = 42 >> 3;
	assert (i == 5);
	i >>= 2;
	assert (i == 1);

	// &
	i = 42 & 23;
	assert (i == 2);
	i &= 1;
	assert (i == 0);

	// |
	i = 42 | 23;
	assert (i == 63);
	i |= 128;
	assert (i == 191);

	// ^
	i = 42 ^ 23;
	assert (i == 61);
	i ^= 23;
	assert (i == 42);

	// equality and relational
	i = 42;
	assert (i == 42);
	assert (i != 50);
	assert (i < 50);
	assert (!(i < 40));
	assert (i <= 42);
	assert (!(i <= 41));
	assert (i >= 42);
	assert (!(i >= 43));
	assert (i > 40);
	assert (!(i > 50));

	// to_string
	string s = i.to_string ();
	assert (s == "42");

	unowned string unparsed;
	s = "%im".printf (int.MIN);
	int.try_parse (s, out i, out unparsed);
	assert (i == int.MIN);
	assert (unparsed == "m");
	s = "%um".printf (uint.MAX);
	assert (!int.try_parse (s, out i));

	s = "%lim".printf (long.MIN);
	long l;
	long.try_parse (s, out l, out unparsed);
	assert (l == long.MIN);
	assert (unparsed == "m");
	s = "%lum".printf (ulong.MAX);
	assert (!long.try_parse (s, out l));

	s = "%um".printf (uint.MAX);
	uint u;
	uint.try_parse (s, out u, out unparsed);
	assert (u == uint.MAX);
	assert (unparsed == "m");
	s = "%im".printf (int.MIN);
	assert (!uint.try_parse (s, out u));

	s = "%lum".printf (ulong.MAX);
	ulong ul;
	ulong.try_parse (s, out ul, out unparsed);
	assert (ul == ulong.MAX);
	assert (unparsed == "m");
	s = "%lim".printf (long.MIN);
	assert (!ulong.try_parse (s, out ul));

	int64 i64;
	int64.try_parse ("-4711inch", out i64, out unparsed);
	assert (i64 == -4711LL);
	assert (unparsed == "inch");
	int64.try_parse ("-31415km", out i64);
	assert (i64 == -31415);

	uint64 ui64;
	uint64.try_parse ("4711yards", out ui64, out unparsed);
	assert (ui64 == 4711ULL);
	assert (unparsed == "yards");
	uint64.try_parse ("31415yards", out ui64);
	assert (ui64 == 31415);

	// ensure that MIN and MAX are valid values
	i = int.MIN;
	assert (i == int.MIN);
	assert (i < int.MAX);
	i = int.MAX;
	assert (i == int.MAX);
	assert (i > int.MIN);
}

void main () {
	test_int ();
}
