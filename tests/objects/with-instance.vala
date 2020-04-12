class Foo {
    public int field;
    public string prop { get; set; }

    public bool method_called = false;
    public void method () {
        method_called = true;
    }
}

class Bar : Foo { }

class TestFoo {
    public static int class_field;
    public int instance_field;

    public void test () {
        var foo = new Foo ();
        var local_field = 0;

        with (foo) {
            field = 10;
            prop = "prop";
            method ();

            local_field = 20;
            class_field = 30;
            instance_field = 40;
        }

        assert (foo.field == 10);
        assert (foo.prop == "prop");
        assert (foo.method_called);

        assert (local_field == 20);
        assert (class_field == 30);
        assert (instance_field == 40);
    }
}

// Copy and paste TestFoo, change Foo to Bar
class TestBar {
    public static int class_field;
    public int instance_field;

    public void test () {
        var foo = new Bar ();
        var local_field = 0;

        with (foo) {
            field = 10;
            prop = "prop";
            method ();

            local_field = 20;
            class_field = 30;
            instance_field = 40;
        }

        assert (foo.field == 10);
        assert (foo.prop == "prop");
        assert (foo.method_called);

        assert (local_field == 20);
        assert (class_field == 30);
        assert (instance_field == 40);
    }
}

void main () {
    new TestFoo ().test ();
    new TestBar ().test ();
}
