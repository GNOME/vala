[CCode (default_value = "{ .i = 23 }")]
[SimpleType]
public struct Foo {
	int i;
}

Foo bar (Object o) {
	return {};
}

void main () {
	Foo foo = {};
	assert (foo.i == 23);
}
