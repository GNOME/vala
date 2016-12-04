public delegate void Func ();

public class Foo {
	public int i;
	public virtual void foo () {
		i = 1;
	}
}

public class Bar : Foo {
	void execute (Func func) {
		func ();
	}

	public override void foo () {
		execute (() => {
			base.foo ();
		});
	}
}

void main () {
	var bar = new Bar ();
	bar.foo ();
	assert (bar.i == 1);
}
