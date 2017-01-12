struct Foo {
	public int64 foo;
	public int64 bar;
}

void bar (uint8[] a) {
	unowned Foo[] f = (Foo[]) a;
	assert (f[0].foo == 2LL << 62);
	assert (f[0].bar == 2LL << 31);
}

void main () {
	unowned uint8[] tu;
	uint8[] to;

	Foo fstack = { 2LL << 62 , 2LL << 31};
	Foo? fheap = { 2LL << 62 , 2LL << 31};

	bar ((uint8[]) &fstack);
	tu = (uint8[]) &fstack;
	assert (tu.length == 16);
	bar (tu);
	to = (uint8[]) &fstack;
	assert (to.length == 16);
	bar (to);

	bar ((uint8[]) fstack);
	tu = (uint8[]) fstack;
	assert (tu.length == 16);
	bar (tu);
	to = (uint8[]) fstack;
	assert (to.length == 16);
	bar (to);

	bar ((uint8[]) fheap);
	tu = (uint8[]) fheap;
	assert (tu.length == 16);
	bar (tu);
	to = (uint8[]) fheap;
	assert (to.length == 16);
	bar (to);

	int32 i32 = 2 << 28;
	tu = (uint8[]) i32;
	assert (tu.length == 4);
	tu = (uint8[]) &i32;
	assert (tu.length == 4);
	to = (uint8[]) i32;
	assert (to.length == 4);

	uint64 u64 = 2UL << 30;
	tu = (uint8[]) u64;
	assert (tu.length == 8);
	tu = (uint8[]) &u64;
	assert (tu.length == 8);
	to = (uint8[]) u64;
	assert (to.length == 8);
}
