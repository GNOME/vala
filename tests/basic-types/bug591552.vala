void main () {
	int a = 1, b = 2;
	int? c = 3, d = 4;
	bool? test = null;

	a = 1; b = 2;
	c = 3; d = 4;
	test = false;

	a = a + b;
	a = b - c;
	a = c & d;
	c = a ^ b;
	c = b | c;
	c = c % d;

	d %= c;
	c |= a & d;

	test = c in d;
	test = b > d;
	test = test || test;
	test = b > c > d < a;

	test = a == c;
	test = c == d;
}
