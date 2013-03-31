public interface IFoo {
	public abstract void i1 ();
}

public interface IBar {
	public abstract void i2 ();
}

public partial class Foo : Object {
	public string p0 { get; set; }
	public string f0;
	public void m0 () {
	}
	public virtual void v0 () {
	}
	public virtual signal void s0 () {
	}
}

public partial class Foo : IFoo {
	public string p1 { get; set; }
	public string f1;
	public void m1 () {
	}
	public virtual void v1 () {
	}
	public virtual signal void s1 () {
	}
	public void i1 () {
	}
}

public partial class Foo : IBar {
	public string p2 { get; set; }
	public string f2;
	public void m2 () {
	}
	public virtual void v2 () {
	}
	public virtual signal void s2 () {
	}
	public void i2 () {
	}
}

void main () {
	var foo = new Foo ();
	foo.p0 = "p0";
	foo.f0 = "f0";
	foo.m0 ();
	foo.v0 ();
	foo.s0 ();

	foo.p1 = "p1";
	foo.f1 = "f1";
	foo.m1 ();
	foo.v1 ();
	foo.s1 ();

	foo.p2 = "p2";
	foo.f2 = "f2";
	foo.m2 ();
	foo.v2 ();
	foo.s2 ();

	assert (foo is IFoo);
	foo.i1 ();
	assert (foo is IBar);
	foo.i2 ();
}
