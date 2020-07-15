namespace Baz {
	public class Foo {
		public class Bar1 {
		}

		public interface IBar1 : Bar1 {
		}
	}
	public interface IFoo : Foo {
		public class Bar2 {
		}

		public interface IBar2 : Bar2 {
		}
	}
}

class Manam : Baz.Foo, Baz.IFoo {
	public Bar1? foo1 () {
		return null;
	}

	public IBar1? ifoo1 () {
		return null;
	}

	public Bar2? foo2 () {
		return null;
	}

	public IBar2? ifoo2 () {
		return null;
	}
}

void main () {
	var manam = new Manam ();
	manam.foo1 ();
	manam.ifoo1 ();
	manam.foo2 ();
	manam.ifoo2 ();
}
