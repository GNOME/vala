class Foo {
    public int field;
}

class Bar {
    public int field;
}

class Test {
    public int field;

    void nested () {
        var foo = new Foo ();
        var bar = new Bar ();

        with (var f = foo) {
            field = 100;
            with (bar) {
                field = 200;
                f.field = 300;
                this.field = 400;
            }
        }

        assert (foo.field == 300);
        assert (bar.field == 200);
        assert (this.field == 400);
    }

    static int main () {
        new Test ().nested ();
        return 0;
    }
}
