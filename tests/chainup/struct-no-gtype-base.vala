[CCode (has_type_id = false)]
struct Foo {
	public int a;
	public int b;

	public int sum () {
		return this.a + this.b;
	}
}

[CCode (has_type_id = false)]
struct Bar : Foo {
	public int mul () {
		return this.a * this.b;
	}

	public int mul2 () {
		return base.a * base.b;
	}
}

void main () {
	Bar bar = { 23, 42 };
	assert (bar.sum () == 65);
	assert (bar.mul () == 966);
	assert (bar.mul2 () == 966);
}
