[Compact]
class Aaa {
    public int i = 42;
}

class Bbb {
    Aaa a = new Aaa ();

    public unowned Aaa get_a () {
        unowned Aaa x = a;
        a = null;
        return x;
    }
}

void p (delegate(owned Aaa) => void d) {
    var a = new Aaa ();
    d ((owned) a);
    assert (a == null);
}

void q (delegate(Aaa) => void d) {
    var a = new Aaa ();
    d (a);
    assert (a.i == 42);
}

void r (delegate() => Aaa d) {
    assert (d ().i == 42);
}

void s (delegate() => unowned Aaa d) {
    assert (d ().i != 42);
}

void main () {
    p ((a) => assert (a.i == 42));
    q ((a) => assert (a.i == 42));
    r (() => new Aaa());
    s (new Bbb().get_a);
}
