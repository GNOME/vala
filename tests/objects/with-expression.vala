class Foo {
    public static int factory_called = 0;
    public static Foo factory() {
        factory_called++;
        return new Foo();
    }

    public static int method_called = 0;
    public void method() {
        method_called++;
    }
}

void test() {
    var foo = new Foo();
    with(foo)
        method();
    
    with(new Foo())
        method();
    
    with(Foo.factory()) {
        method();
        method();
    }

    assert(Foo.method_called == 4);
    assert(Foo.factory_called == 1);
}

void main() {
    test();
}

