delegate int Foo (int i);

[CCode (has_target = false)]
delegate int Bar (int i);

void foo (Foo f) {
	assert (f (13) == 39);
}

void bar (Bar b) {
	assert (b (42) == 84);
}

void main () {
	{
		int j = 3;
		int func (int i) {
			return i * j;
		}
		foo (func);

		Foo f = func;
		assert (f (23) == 69);
	}
	{
		static int func (int i) {
			return 2 * i;
		}
		bar (func);

		Bar b = func;
		assert (b (23) == 46);
	}
}

