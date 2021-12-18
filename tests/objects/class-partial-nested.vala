namespace Manam.Foo {
	public partial class Bar.Baz {
		public string p0 { get; set; }
		public string f0;
		public void m0 () {
		}
		public virtual void v0 () {
		}
	}
}

namespace Manam.Foo {
	public partial class Bar.Baz {
		public string p1 { get; set; }
		public string f1;
		public void m1 () {
		}
		public virtual void v1 () {
		}
	}
}

void main () {
	var baz = new Manam.Foo.Bar.Baz ();
	baz.p0 = "p0";
	baz.f0 = "f0";
	baz.m0 ();
	baz.v0 ();

	baz.p1 = "p1";
	baz.f1 = "f1";
	baz.m1 ();
	baz.v1 ();
}
