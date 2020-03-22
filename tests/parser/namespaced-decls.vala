using Foo.Bar;

void Foo.Bar.inner_foo () {}

void main() {
    Foo.Bar.inner_foo ();
    inner_foo ();
}
