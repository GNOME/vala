interface IFoo : Object {
	public abstract async void foo_async () throws Error;
	public abstract void foo () throws Error;
}

class Bar : Object, IFoo {
	public virtual async void foo_async () {
	}
	public virtual void foo () {
	}
}

class SubBar : Bar {
	public override async void foo_async () {
	}
	public override void foo () {
	}
}

abstract class AFoo : Object {
	public abstract async void foo_async () throws Error;
	public abstract void foo () throws Error;
}

class Baz : AFoo {
	public override async void foo_async () {
	}
	public override void foo () {
	}
}

class SubBaz : Baz {
	public override async void foo_async () {
	}
	public override void foo () {
	}
}

async void run () {
	var bar = new Bar ();
	bar.foo ();
	yield bar.foo_async ();

	var subbar = new SubBar ();
	subbar.foo ();
	yield subbar.foo_async ();

	var baz = new Baz ();
	baz.foo ();
	yield bar.foo_async ();

	var subbaz = new SubBaz ();
	subbaz.foo ();
	yield subbaz.foo_async ();
}

void main () {
	run.begin ();
}
