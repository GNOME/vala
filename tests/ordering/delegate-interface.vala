[CCode (has_target = false)]
delegate Foo Func (Foo p);

interface Foo {
	public abstract Func foo (Func p);
}

void main () {
}
