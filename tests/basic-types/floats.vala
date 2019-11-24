void test_double () {
	// declaration and initialization
	double d = 42d;
	assert (d == 42d);

	// assignment
	d = 23d;
	assert (d == 23d);

	// access
	double e = d;
	assert (e == 23d);

	// exponent
	d = 1.0E-5;
	assert (d == 0.00001);
	d = 1.0E+4;
	assert (d == 10000.0);

	// +
	d = 42d + 23d;
	assert (d == 65d);

	// -
	d = 42d - 23d;
	assert (d == 19d);

	// *
	d = 42d * 23d;
	assert (d == 966d);

	// /
	d = 42d / 23d;
	assert (d > 1.8);
	assert (d < 1.9);

	// equality and relational
	d = 42d;
	assert (d == 42d);
	assert (d != 50d);
	assert (d < 42.5);
	assert (!(d < 41.5));
	assert (d <= 42d);
	assert (!(d <= 41.5));
	assert (d >= 42d);
	assert (!(d >= 42.5));
	assert (d > 41.5);
	assert (!(d > 42.5));

	// to_string
	string s = d.to_string ();
	assert (s == "42");

	d = double.parse ("47.11mm");
	assert (d == 47.11);

	unowned string unparsed;
	double.try_parse ("3.45mm", out d, out unparsed);
	assert (d == 3.45);
	assert (unparsed == "mm");

	// ensure that MIN and MAX are valid values
	d = double.MIN;
	assert (d == double.MIN);
	assert (d < double.MAX);
	d = double.MAX;
	assert (d == double.MAX);
	assert (d > double.MIN);

	// nullable
	double? d2 = 10;
	assert (d2 == 10);
}

void test_float () {
	// declaration and initialization
	float f = 42f;
	assert (f == 42f);

	// assignment
	f = 23f;
	assert (f == 23f);

	// access
	float g = f;
	assert (g == 23f);

	// +
	f = 42f + 23f;
	assert (f == 65f);

	// -
	f = 42f - 23f;
	assert (f == 19f);

	// *
	f = 42f * 23f;
	assert (f == 966f);

	// /
	f = 42f / 23f;
	assert (f > 1.8);
	assert (f < 1.9);

	// equality and relational
	f = 42f;
	assert (f == 42f);
	assert (f != 50f);
	assert (f < 42.5f);
	assert (!(f < 41.5f));
	assert (f <= 42f);
	assert (!(f <= 41.5f));
	assert (f >= 42f);
	assert (!(f >= 42.5f));
	assert (f > 41.5f);
	assert (!(f > 42.5f));

	// to_string
	string s = f.to_string ();
	assert (s == "42");

	f = float.parse ("47.11mm");
	assert (f == 47.11f);

	unowned string unparsed;
	float.try_parse ("3.45mm", out f, out unparsed);
	assert (f == 3.45f);
	assert (unparsed == "mm");

	// ensure that MIN and MAX are valid values
	f = float.MIN;
	assert (f == float.MIN);
	assert (f < float.MAX);
	f = float.MAX;
	assert (f == float.MAX);
	assert (f > float.MIN);

	// nullable
	float? f2 = 10f;
	assert (f2 == 10f);
}

void main () {
	test_double ();
	test_float ();
}
