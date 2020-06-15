struct Bar {
	int i;
	double d;
}

void foo (int a[3]) {
	assert (a[2] == 4711);
}

void bar (Bar b[3]) {
	assert (b[2].i == 23);
	assert (b[2].d == 47.11);
}

void main () {
	foo ({ 23, 42, 4711 });

	Bar b = { 23, 47.11 };
	bar ({b, b, b});
}
