class Foo {
    public int field;
}

class Bar {
    public int field;
}

class Test {
    public int field;

    void method_local() {
        var field = 0;
        var foo = new Foo();

        with (foo) {
            field = 10;
            //with.field = 20;
            this.field = 30;
        }

        assert (foo.field == 10);
        //assert (field == 20);
        assert (this.field == 30);
    }

    void nested() {
        var field = 0;
        var foo = new Foo();
        var bar = new Bar();

        with (foo) {
            field = 100;
            with (bar) {
                field = 200;
                //with.with.field = 300;
            }
        }

        assert (foo.field == 100);
        assert (bar.field == 200);
        //assert (field == 300);

        /*with (foo) {
            field = 1000;
            with (bar) {
                field = with.field;
                this.field = 2000;
            }
        }

        assert (bar.field == 1000);
        assert (this.field == 2000);*/
    }

    void nested_useless() {
        var field = 0;
        var foo = new Foo();
        var bar = new Bar();

        /*with (foo) {
            with.this.field = 10000;
            with.foo.field = 20000;
        }

        assert (this.field == 10000);
        assert (foo.field == 20000);

        with (foo) {
            with (bar) {
                field = 30000;
                with.field = 40000;
                with.with.field = 50000;
            }
        }

        assert (bar.field == 30000)
        assert (foo.field == 40000);
        assert (field == 50000);*/
    }

    static int main() {
        new Test().method_local();
        new Test().nested();
        new Test().nested_useless();
        return 0;
    }
}