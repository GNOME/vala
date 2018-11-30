class Base : Object {
	public void foo () {
	}
}

interface IFoo : Base {
	public abstract string foo ();
}

interface IBar : Base {
	public abstract int foo ();
}

class Manam : Base, IFoo, IBar {
	public int IBar.foo () {
		return 23;
	}
	public string IFoo.foo () {
		return "foo";
	}
}

void main () {
	var manam = new Manam ();
	assert (((IFoo) manam).foo () == "foo");
	assert (((IBar) manam).foo () == 23);
}
