[CCode (has_target = false)]
delegate Foo Func (Foo p);

class Foo {
	public Func foo (Func p) {
		return p;
	}
}

void main () {
}
