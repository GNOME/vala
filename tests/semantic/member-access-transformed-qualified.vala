using Foo.Bar;
using Foo.Manam;

namespace Foo.Bar {
	public int bar = 23;
}

namespace Foo.Manam {
	public class Foo {
		public static void faz () {
			bar = 42;
		}
	}
}

void main () {
	assert (bar == 23);
	Foo.Manam.Foo.faz ();
	assert (bar == 42);
}
