[CCode (array_length_type = "guint8")]
delegate int[] FooFunc ([CCode (array_length_type = "guint8")] owned int[] p);

interface IFoo {
	[CCode (array_length_type = "guint8")]
	public abstract int[] manam { get; set; }

	[CCode (array_length_type = "guint8")]
	public abstract int[] get_foo ();
	public abstract void set_foo ([CCode (array_length_type = "guint8")] out int[] p);
}

class Foo : IFoo {
	public int[] manam { get; set; }

	[CCode (array_length_type = "guint8")]
	public virtual int[] manar { get; set; }

	public int[] get_foo () {
		var res = new int[255];
		res[254] = 4711;
		return res;
	}

	public void set_foo (out int[] p) {
		p = new int[255];
		p[254] = 4711;
	}

	[CCode (array_length_type = "guint8")]
	public virtual int[] get_bar () {
		var res = new int[255];
		res[254] = 4711;
		return res;
	}

	public virtual void set_bar ([CCode (array_length_type = "guint8")] out int[] p) {
		p = new int[255];
		p[254] = 4711;
	}

	public Foo () {
		{
			var a = get_foo ();
			assert (a.length == 255);
			assert (a[254] == 4711);
		}
		{
			int[] a = null;
			set_foo (out a);
			assert (a.length == 255);
			assert (a[254] == 4711);
		}
	}
}

class Bar : Foo {
	public override int[] manar { get; set; }

	public override int[] get_bar () {
		var res = new int[255];
		res[254] = 4711;
		return res;
	}

	public override void set_bar (out int[] p) {
		p = new int[255];
		p[254] = 4711;
	}

	public Bar () {
		{
			var a = get_foo ();
			assert (a.length == 255);
			assert (a[254] == 4711);
		}
		{
			int[] a = null;
			set_foo (out a);
			assert (a.length == 255);
			assert (a[254] == 4711);
		}
		{
			var a = get_bar ();
			assert (a.length == 255);
			assert (a[254] == 4711);
		}
		{
			int[] a = null;
			set_bar (out a);
			assert (a.length == 255);
			assert (a[254] == 4711);
		}
	}
}

[CCode (array_length_type = "guint8")]
int[] get_foo () {
	var res = new int[255];
	res[254] = 4711;
	return res;
}

void set_foo ([CCode (array_length_type = "guint8")] out int[] p) {
	p = new int[255];
	p[254] = 4711;
}

[CCode (array_length_type = "guint8")]
int[] foo_func ([CCode (array_length_type = "guint8")] owned int[] p) {
	return p;
}

void main () {
	{
		FooFunc f = (a) => { return a; };
		int[] a = new int[255];
		a[254] = 4711;
		a = f ((owned) a);
		assert (a.length == 255);
		assert (a[254] == 4711);
	}
	{
		FooFunc f = (FooFunc) foo_func;
		int[] a = new int[255];
		a[254] = 4711;
		a = f ((owned) a);
		assert (a.length == 255);
		assert (a[254] == 4711);
	}
	{
		var a = get_foo ();
		assert (a.length == 255);
		assert (a[254] == 4711);
	}
	{
		int[] a = null;
		set_foo (out a);
		assert (a.length == 255);
		assert (a[254] == 4711);
	}
	{
		var foo = new Foo ();
		foo.manam = new int[255];
		foo.manam[254] = 4711;
		assert (foo.manam.length == 255);
		assert (foo.manam[254] == 4711);
	}
	{
		var bar = new Bar ();
		bar.manar = new int[255];
		bar.manar[254] = 4711;
		assert (bar.manar.length == 255);
		assert (bar.manar[254] == 4711);
	}
}
