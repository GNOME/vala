using Foo.Bar;

void Foo.Bar.inner_foo () {
    assert (BAR == 3);
    assert (pi == 4);
}
const int Foo.BAR = 3;
int Foo.Bar.pi = 4;

void main() {
    Foo.Bar.inner_foo ();
    inner_foo ();
    assert (Foo.BAR == 3);
    assert (Foo.Bar.pi == pi);
}
