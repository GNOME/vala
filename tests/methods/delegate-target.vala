delegate void FooFunc ();

interface IFoo {
	[CCode (delegate_target = false)]
	public abstract FooFunc? get_foo ();
	public abstract void do_foo ([CCode (delegate_target = false)] FooFunc f);
}

class Foo : IFoo {
	public virtual FooFunc? get_foo () {
		return () => {};
	}

	public virtual void do_foo (FooFunc f) {
		assert (f.target == null);
		f ();
	}

	[CCode (delegate_target = false)]
	public virtual FooFunc? get_bar () {
		return () => {};
	}

	public virtual void do_bar ([CCode (delegate_target = false)] FooFunc f) {
		assert (f.target == null);
		f ();
	}

	public Foo () {
		{
			var f = get_foo ();
			assert (f.target == null);
			f ();
		}
		{
			do_foo (() => {});
		}
	}
}

class Bar : Foo {
	public override FooFunc? get_foo () {
		return () => {};
	}

	public override void do_foo (FooFunc f) {
		assert (f.target == null);
		f ();
	}

	public override FooFunc? get_bar () {
		return () => {};
	}

	public override void do_bar (FooFunc f) {
		assert (f.target == null);
		f ();
	}

	public Bar () {
		{
			var f = get_foo ();
			assert (f.target == null);
			f ();
		}
		{
			do_foo (() => {});
		}
		{
			var f = get_bar ();
			assert (f.target == null);
			f ();
		}
		{
			do_bar (() => {});
		}
	}
}

[CCode (delegate_target = false)]
FooFunc? get_foo () {
	return () => {};
}

void do_foo ([CCode (delegate_target = false)] FooFunc f) {
	assert (f.target == null);
	f ();
}

void main () {
	{
		var f = get_foo ();
		assert (f.target == null);
		f ();
	}
	{
		do_foo (() => {});
	}
	{
		var foo = new Foo ();
	}
	{
		var bar = new Bar ();
	}
}
