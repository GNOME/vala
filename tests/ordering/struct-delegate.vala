public struct Foo {
	public unowned Func func;
}

[CCode (has_target = false)]
public delegate int Func (Foo foo);

void main () {
}
