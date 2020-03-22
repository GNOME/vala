using Foo.Bar;

void Foo.Bar.inner_foo () {
    assert (BAR == 3);
}
const int Foo.BAR = 3;

void main() {
    Foo.Bar.inner_foo ();
    inner_foo ();
    assert (Foo.BAR == 3);
}
