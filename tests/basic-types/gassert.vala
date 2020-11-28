void test_assert_cmpstr () {
	// assume g_strcmp0() behaviour for nulls
	assert_cmpstr (null, EQ, null);
	assert_cmpstr ("", GT, null);
	assert_cmpstr (null, LT, "");
	assert_cmpstr (null, LT, "");
	assert_cmpstr (null, NE, "some non-null, non-empty string");
	assert_cmpstr (null, LT, "some non-null, non-empty string");
	assert_cmpstr (null, LE, "some non-null, non-empty string");
	assert_cmpstr ("some non-null, non-empty string", NE, null);
	assert_cmpstr ("some non-null, non-empty string", GT, null);
	assert_cmpstr ("some non-null, non-empty string", GE, null);

	assert_cmpstr ("0", LT, "1");
	assert_cmpstr ("0", LE, "1");
	assert_cmpstr ("1", LE, "1");
	assert_cmpstr ("2", EQ, "2");
	assert_cmpstr ("3", GE, "3");
	assert_cmpstr ("4", GE, "3");
	assert_cmpstr ("4", GT, "3");
	assert_cmpstr ("4", NE, "3");
}

void test_assert_cmpint () {
	assert_cmpint (0, LT, 1);
	assert_cmpint (0, NE, 1);
	assert_cmpint (0, LE, 1);
	assert_cmpint (1, LE, 1);
	assert_cmpint (1, EQ, 1);
	assert_cmpint (1, GE, 1);
	assert_cmpint (2, GE, 1);
	assert_cmpint (2, GT, 1);

	assert_cmpint (-1, GT, -2);
	assert_cmpint (-1, NE, -2);
	assert_cmpint (-1, GE, -2);
	assert_cmpint (-2, GE, -2);
	assert_cmpint (-2, EQ, -2);
	assert_cmpint (-2, LE, -2);
	assert_cmpint (-3, LE, -2);
	assert_cmpint (-3, LT, -2);

	assert_cmpint (-100, LT, 101);
	assert_cmpint (-100, NE, 101);
	assert_cmpint (-100, LE, 101);
	assert_cmpint (-101, LE, 101);
	assert_cmpint (101, GE, -101);
	assert_cmpint (102, GE, -101);
	assert_cmpint (102, GT, -101);
}

void test_assert_cmpuint () {
	assert_cmpuint (0U, LT, 1U);
	assert_cmpuint (0U, NE, 1U);
	assert_cmpuint (0U, LE, 1U);
	assert_cmpuint (1U, LE, 1U);
	assert_cmpuint (1U, EQ, 1U);
	assert_cmpuint (1U, GE, 1U);
	assert_cmpuint (2U, GE, 1U);
	assert_cmpuint (2U, GT, 1U);
}

void test_assert_cmphex () {
	assert_cmphex (0x0, LT, 0x1);
	assert_cmphex (0x0, NE, 0x1);
	assert_cmphex (0x0, LE, 0x1);
	assert_cmphex (0x1, LE, 0x1);
	assert_cmphex (0x1, EQ, 0x1);
	assert_cmphex (0x1, GE, 0x1);
	assert_cmphex (0x2, GE, 0x1);
	assert_cmphex (0x2, GT, 0x1);
}

void test_assert_cmpfloat () {
	assert_cmpfloat (0.0f, LT, 1.0f);
	assert_cmpfloat (0.0f, NE, 1.0f);
	assert_cmpfloat (0.0f, LE, 1.0f);
	assert_cmpfloat (1.0f, LE, 1.0f);
	assert_cmpfloat (1.0f, EQ, 1.0f);
	assert_cmpfloat (1.0f, GE, 1.0f);
	assert_cmpfloat (2.0f, GE, 1.0f);
	assert_cmpfloat (2.0f, GT, 1.0f);

	assert_cmpfloat (-1.0f, GT, -2.0f);
	assert_cmpfloat (-1.0f, NE, -2.0f);
	assert_cmpfloat (-1.0f, GE, -2.0f);
	assert_cmpfloat (-2.0f, GE, -2.0f);
	assert_cmpfloat (-2.0f, EQ, -2.0f);
	assert_cmpfloat (-2.0f, LE, -2.0f);
	assert_cmpfloat (-3.0f, LE, -2.0f);
	assert_cmpfloat (-3.0f, LT, -2.0f);

	assert_cmpfloat (-100.0f, LT, 101.0f);
	assert_cmpfloat (-100.0f, NE, 101.0f);
	assert_cmpfloat (-100.0f, LE, 101.0f);
	assert_cmpfloat (-101.0f, LE, 101.0f);
	assert_cmpfloat (101.0f, GE, -101.0f);
	assert_cmpfloat (102.0f, GE, -101.0f);
	assert_cmpfloat (102.0f, GT, -101.0f);
}

void main () {
	test_assert_cmpstr ();
	test_assert_cmpint ();
	test_assert_cmpuint ();
	test_assert_cmphex ();
	test_assert_cmpfloat ();
}
