void main () {
    f (t);
}

string t (Comp<string> a, Comp<string> b) {
    return a.a + b.a;
}


void f (delegate(Comp<string>, Comp<string>) => string abc) {
    assert (abc(new Comp<string> ("x"), new Comp<string> ("y")) == "xy");
}

class Comp<A> {
    public A a { get; private set; }

    public Comp (A a) {
        this.a = a;
    }
}
