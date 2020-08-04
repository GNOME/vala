interface IFoo {
	[CCode (returns_floating_reference = true)]
	public abstract InitiallyUnowned? foo ();
}

interface IBar {
	[CCode (returns_floating_reference = true)]
	public abstract InitiallyUnowned? bar ();
}

class Foo : IFoo, IBar {
	[CCode (returns_floating_reference = true)]
	public InitiallyUnowned? foo () {
		return null;
	}

	public InitiallyUnowned? bar () {
		return null;
	}

	[CCode (returns_floating_reference = true)]
	public virtual InitiallyUnowned? faz () {
		return null;
	}

	[CCode (returns_floating_reference = true)]
	public virtual InitiallyUnowned? baz () {
		return null;
	}
}

class Manam : Foo {
	[CCode (returns_floating_reference = true)]
	public override InitiallyUnowned? faz () {
		return null;
	}

	public override InitiallyUnowned? baz () {
		return null;
	}
}

void main () {
	var manam = new Manam ();
	manam.foo ();
	manam.bar ();
	manam.faz ();
	manam.baz ();
}
