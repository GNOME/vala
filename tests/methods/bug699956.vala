class Foo {
}

class Bar : Foo {
}

[CCode (type = "methodsbug699956Foo*")]
Bar? foo () {
	return null;
}

void main () {
	foo ();
}
