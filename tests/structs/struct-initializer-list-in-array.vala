#!/usr/bin/env -S vala

public struct Foo {
	public int i;
	public string s;
	public Bar b;
	public bool[] bs;
}

public struct Bar {
	public int i;
}

void main () {
	Foo[] foos = {
		{ 1, "foo", { 2 }, { true } },
		{ 2, "bar", { 3 }, { false } },
	};

	var f = foos[0];
	assert(f.i == 1 && f.s == "foo" && f.b.i == 2 && f.bs[0]);

	f = foos[1];
	assert(f.i == 2 && f.s == "bar" && f.b.i == 3 && !f.bs[0]);
}
