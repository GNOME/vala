class Foo {
    public int i;
}

void main () {
    Foo? f = null;
    Process.exit (0);

    with (f) {
        i = 7;
    }
}
