delegate int Deleg1 (ref int foo);
delegate void Deleg2 (out Value foo, ref int bar);

void main () {
	int a = 3, b = 4;
	Value c;
	Deleg1 d1 = ref foo => foo + 5;
	Deleg2 d2 = (out foo, ref bar) => { foo = 10; bar = 3; };
	assert (d1 (ref a) == 8);
	d2 (out c, ref b);
	assert (c == 10);
	assert (b == 3);
}
