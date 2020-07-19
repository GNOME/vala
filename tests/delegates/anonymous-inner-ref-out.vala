void main () {
    f (t);
    g (d);
}

void f (delegate(ref int) => void x) {
    int i = 42;
    x (ref i);
    assert (i == 7);
}

void g (delegate(out int) => void y) {
    int i;
    y (out i);
    assert (i == 42);
}

void t (ref int a) {
    a = 7;
}

void d (out int a) {
    a = 42;
}
