namespace Manam {
	namespace Bar {
		public struct Foo {
			public int i;
			public int j;
		}
	}

	public class Baz {
		public struct Faz {
			public string s;
			public uint i;
		}
	}
}

void main () {
	Manam.Bar.Foo[] foo = { { 42, 4711 }, { 23, 17 } };
	assert (foo.length == 2);
	assert (foo[0].i == 42);
	assert (foo[1].j == 17);

	Manam.Baz.Faz[] faz = { { "manam", 4711U } };
	assert (faz.length == 1);
	assert (faz[0].s == "manam");
	assert (faz[0].i == 4711U);
}
