const int[,] FOO = { { 1, 2 }, { 3, 4 }, { 5, 6 }, { 6, 7, 8 }, { 9 }};
const string[,] BAR = { { "a", "b" }, { "c", "d" }, { "e", "f" }, { "g", "h", "i" }, { "j" }};

void main () {
	assert (FOO.length[0] == 5);
	assert (FOO.length[1] == 3);
	assert (FOO[0,1] == 2);
	assert (FOO[3,2] == 8);

	int[,] foo = FOO;
	assert (foo.length[0] == 5);
	assert (foo.length[1] == 3);
	assert (foo[0,1] == 2);
	assert (foo[3,2] == 8);

	assert (BAR.length[0] == 5);
	assert (BAR.length[1] == 3);
	assert (BAR[0,1] == "b");
	assert (BAR[3,2] == "i");

	string[,] bar = BAR;
	assert (bar.length[0] == 5);
	assert (bar.length[1] == 3);
	assert (bar[0,1] == "b");
	assert (bar[3,2] == "i");
}
