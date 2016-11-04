public class Foo {
	int i;
	public Foo () {
		i = 0;
	}

	public Foo.foo () {
		SourceFunc f = () => true;
		f ();
	}
}

public struct Bar {
	int i;
	public Bar () {
		i = 0;
	}
}

void main () {
}
