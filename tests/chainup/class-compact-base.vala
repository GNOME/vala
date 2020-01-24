[Compact]
public class Foo {
	public int a;
	public int b;

	public Foo () {
		a = 23;
	}

	public int sum () {
		return this.a + this.b;
	}
}

public class Bar : Foo {
	public Bar () {
		base ();
		this.b = 42;
	}

	public int mul () {
		return this.a * this.b;
	}

	public int mul2 () {
		return base.a * base.b;
	}
}

void main () {
	var bar = new Bar ();
	assert (bar.a == 23);
	assert (bar.b == 42);
	assert (bar.sum () == 65);
	assert (bar.mul () == 966);
	assert (bar.mul2 () == 966);
}
