class Foo {
}

class Bar : Foo {
}

void main () {
    with (Foo f = new Bar ()) {
    }
}
