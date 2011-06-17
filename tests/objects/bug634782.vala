public class Foo {
        public uint8[] baz;
        public Foo bar () { return new Foo (); }
}

void main () {
        Foo foo = new Foo ();
        var bar = foo.bar().baz;
}
