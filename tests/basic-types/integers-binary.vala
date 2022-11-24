void main () {
	var a = 0b1001;
	assert (a == 9);

	var b = 0b100111010u;
	assert (b == 314);

	var c = -0b1010011010;
	assert (c == -666);

	uint64 d = 0b1111111111111111111111111111111111111111111111111111111111111111;
	assert (d == 0xffffffffffffffff);

	int64 e = 0b11011110111011011011111011101111;
	assert (e == 0xdeedbeef);
}
