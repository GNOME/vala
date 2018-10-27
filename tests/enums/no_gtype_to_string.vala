[CCode (has_type_id = false)]
enum Foo {
	BAR,
	MANAM,
	BAZ_FAZ
}

[CCode (has_type_id = false)]
[Flags]
enum Bar {
	FOO,
	MANAM,
	FAZ_BAZ
}

void main () {
	assert ("FOO_BAR" == Foo.BAR.to_string ());
	assert ("FOO_BAZ_FAZ" == Foo.BAZ_FAZ.to_string ());

	assert ("BAR_FOO" == Bar.FOO.to_string ());
	assert ("BAR_FAZ_BAZ" == Bar.FAZ_BAZ.to_string ());
}
