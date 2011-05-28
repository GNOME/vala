public delegate void Bar ();

class Foo {
        public unowned Bar bar { get; set; }
}

async void test () {
        var foo = new Foo ();
        var i = 0;
        foo.bar = () => { i++; };
        foo.bar ();
}

void main() {
        test ();
}
