namespace Foo {
	using Bar;

	public void foo () {
		bar ();
	}
}

namespace Bar {
	public void bar () {
	}
}

void main () {
	Foo.foo ();
}
