struct Manam {
    int a;
}

class BaseFoo : Object {
    public virtual Manam st { get; set; }
}

class Foo : Object {
    public virtual Manam st { get; set; }
}

class Bar : Foo {
    public override Manam st {
        get { return base.st; }
        set { base.st = value; }
    }
}

class Baz : BaseFoo {
    public override Manam st {
        get { return base.st; }
        set { base.st = value; }
    }
}

void main () {
    var bar = new Bar ();
    bar.st = { 42 };
    assert (bar.st.a == 42);

    var baz = new Baz ();
    baz.st = { 23 };
    assert (baz.st.a == 23);
}
