struct Foo {
    uint x;
    int y;
}

class Bar {
    public string s;
}

void main() {
    var foo = Foo () {
		x = (uint) 23,
		y = 42
    };
    assert (foo.x == 23U);
    assert (foo.y == 42);

    var bar = new Bar () {
		s = "bar"
    };
    assert (bar.s == "bar");
}
