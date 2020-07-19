int func (int a, int b) {
	return a + b;
}

void foo (delegate(int, int) => int p, int r) {
	assert (p (23, 42) == r);
}

void bar (int r, owned delegate(int, int) => int p) {
	assert (p (23, 42) == r);
}

void manam ([CCode (has_target = false)] delegate(int, int) => int p, int r) {
	assert (p (23, 42) == r);
}

void main () {
	foo (func, 65);
	bar (65, func);
	manam (func, 65);
}
