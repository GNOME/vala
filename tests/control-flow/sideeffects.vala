class Maman.Foo : Object {
	public int i = 1;

	public weak Foo sideeffect () {
		--i;
		return this;
	}
	public string data;
}

class Maman.Bar : Object {
	public static int main () {
		var foo = new Foo ();
		foo.sideeffect ().data = "foo";
		assert (foo.i == 0);
		return 0;
	}
}

void main () {
	Maman.Bar.main ();
}
