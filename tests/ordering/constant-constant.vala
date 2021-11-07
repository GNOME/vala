const int FOO_BAR = FOO + BAR;

const int BAR = FOO;

const int FOO = 42;

void main () {
	assert (BAR == 42);
	assert (FOO_BAR == 84);
}
