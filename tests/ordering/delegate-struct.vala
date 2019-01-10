[CCode (has_target = false)]
delegate Foo Func (Foo p);

struct Foo {
	public Func f;
}

void main () {
}
