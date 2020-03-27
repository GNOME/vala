[Compact]
class Foo {
    public int i;
}

void main () {
    var foo = new Foo ();
    with (foo) {
        i = 13;
    }

    assert (foo.i == 13);
}
