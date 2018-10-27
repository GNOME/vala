class Foo {
}

class Bar : Foo {
}

[CCode (type = "Foo*")]
Bar? foo () {
	return null;
}

void main () {
	foo ();
}
