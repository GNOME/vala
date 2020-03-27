class Foo {
    public int i;
}

void main () {
    var f = new Foo ();
    var p = &f;

    with (*p) {
        i = 13;
    }

    assert (f.i == 13);
}
