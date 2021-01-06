struct Foo {
	string s;
}

Foo? get_foo () {
	return { "foo" };
}

class Manam : Object {
	public virtual Foo faz { get; set; }
}

class Bar : Manam {
	public Foo foo { get; set; }

	public Bar () {
		{
			this.foo = get_foo ();
		}
		{
			base.faz = get_foo ();
		}
		{
			this.foo = (!) get_foo ();
		}
		{
			base.faz = (!) get_foo ();
		}
		{
			this.foo = (Foo) get_foo ();
		}
		{
			base.faz = (Foo) get_foo ();
		}
		{
			var f = get_foo ();
			this.foo = (!) f;
		}
		{
			var f = get_foo ();
			base.faz = (!) f;
		}
		{
			var f = get_foo ();
			this.foo = (Foo) f;
		}
		{
			var f = get_foo ();
			base.faz = (Foo) f;
		}
	}
}

void main() {
	var bar = new Bar ();
}
