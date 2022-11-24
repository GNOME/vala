void main () {
	var a = 0o644;
	assert (a == 420);

	var b = 0o105264631u;
	assert (b == 18180505u);

	var c = -0o1322;
	assert (c == -722);

	var d = 0o1777777777777777777777ll;
	assert (d == 0xffffffffffffffff);

	var e = -0o33653337357;
	assert (e == -0xdeadbeef);
}
