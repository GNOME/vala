[CCode (has_type_id = false)]
enum Foo {
	MANAM
}

[CCode (has_type_id = false)]
[Flags]
enum Bar {
	MANAM
}

void main () {
	assert (typeof (Foo) == typeof (int));
	assert (typeof (Bar) == typeof (uint));
}
