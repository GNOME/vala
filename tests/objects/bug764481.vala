[SimpleType]
[CCode (has_type_id = false)]
struct Minim {
    int a;
}

struct Manam {
    int a;
}

class BaseFoo : Object {
    public virtual Manam st { get; set; }
    public virtual Minim sst { get; set; }
}

class Foo : Object {
    public virtual Manam st { get; set; }
    public virtual Minim sst { get; set; }
}

class Bar : Foo {
    public override Manam st {
        get { return base.st; }
        set { base.st = value; }
    }
    public override Minim sst {
        get { return base.sst; }
        set { base.sst = value; }
    }
}

class Baz : BaseFoo {
    public override Manam st {
        get { return base.st; }
        set { base.st = value; }
    }
    public override Minim sst {
        get { return base.sst; }
        set { base.sst = value; }
    }
}

void main () {
    var bar = new Bar ();
    bar.st = { 42 };
    bar.sst = { 42 };
    assert (bar.st.a == 42);
    assert (bar.sst.a == 42);

    var baz = new Baz ();
    baz.st = { 23 };
    baz.sst = { 23 };
    assert (baz.st.a == 23);
    assert (baz.sst.a == 23);
}
