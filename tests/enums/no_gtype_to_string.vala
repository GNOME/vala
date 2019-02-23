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
	assert ("ENUMS_NO_GTYPE_TO_STRING_FOO_BAR" == Foo.BAR.to_string ());
	assert ("ENUMS_NO_GTYPE_TO_STRING_FOO_BAZ_FAZ" == Foo.BAZ_FAZ.to_string ());

	assert ("ENUMS_NO_GTYPE_TO_STRING_BAR_FOO" == Bar.FOO.to_string ());
	assert ("ENUMS_NO_GTYPE_TO_STRING_BAR_FAZ_BAZ" == Bar.FAZ_BAZ.to_string ());
}
