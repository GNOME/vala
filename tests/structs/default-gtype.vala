struct Foo {
	public int field;
}

[CCode (has_type_id = false)]
struct Bar : Foo {
}

void main () {
	assert (typeof (Bar) == typeof (Foo));
}
