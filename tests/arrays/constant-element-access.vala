const string[,] FOO = {
    { "00", "01", "02" },
    { "10", "11", "12" },
    { "20", "21", "22" }
};

void main () {
	const string[,] BAR = {
		{ "00", "01", "02" },
		{ "10", "11", "12" },
		{ "20", "21", "22" }
	};

	for (int i = 0; i < FOO.length[0]; i++) {
		assert (FOO[i,0] == "%d%d".printf (i, 0));
		assert (FOO[i,1] == "%d%d".printf (i, 1));
		assert (FOO[i,2] == "%d%d".printf (i, 2));
	}

	for (int i = 0; i < BAR.length[0]; i++) {
		assert (BAR[i,0] == "%d%d".printf (i, 0));
		assert (BAR[i,1] == "%d%d".printf (i, 1));
		assert (BAR[i,2] == "%d%d".printf (i, 2));
	}

	assert (FOO[0,0] == "%d%d".printf (0, 0));
	assert (FOO[1,1] == "%d%d".printf (1, 1));
	assert (FOO[2,2] == "%d%d".printf (2, 2));

	assert (BAR[0,0] == "%d%d".printf (0, 0));
	assert (BAR[1,1] == "%d%d".printf (1, 1));
	assert (BAR[2,2] == "%d%d".printf (2, 2));
}
