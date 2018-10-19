delegate void Func ();
delegate void CompatibleFunc ();

interface Foo : Object {
	public abstract void foo (Func? func);
}

class Bar : Object, Foo {
	public void foo (CompatibleFunc? func) {
	}
}

void main () {
}
