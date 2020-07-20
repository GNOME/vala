abstract class Foo {
	public virtual signal void foo () {
	}

	public abstract void baz ();

	public virtual void manam () {
	}
}

class Bar : Foo {
	public override void foo () {
		assert (base.foo != null);
	}

	public override void baz () {
		assert (base.baz != null);
	}

	public override void manam () {
		assert (base.manam != null);
	}
}

void main () {
	var bar = new Bar ();
	bar.foo ();
	bar.baz ();
	bar.manam ();
}
