public struct Foo {
        uint8 param;
}

void main() {
	bool b = true;
	var foo = Foo() { param = b ? 10 : 20 };
	assert (foo.param == 10);
}
