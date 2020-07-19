void f (delegate([CCode (type = "gint8")] int) => void d) {
    d (300);
}

void t (int a) {
    assert (a == 44);
}

void main () {
    f (t);
}
