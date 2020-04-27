class Foo {
    public int i;
    public int j;
}

void main () {
    var foo = new Foo ();
    with (foo) {
        i = 10;
    }

    assert (foo.i == 10);
    with (var f = foo) {
        i = 100;
        f.j = 200;
    }

    assert (foo.i == 100);
    assert (foo.j == 200);
    with (Foo f = foo) {
        i = 1000;
        f.j = 2000;
    }

    assert (foo.i == 1000);
    assert (foo.j == 2000);
    Foo f;
    with (f = foo) {
        i = 10000;
        f.j = 20000;
    }

    assert (f.i == 10000);
    assert (foo.j == 20000);
}
