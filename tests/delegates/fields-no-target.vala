public delegate void FooFunc ();

[CCode (delegate_target = false)]
public FooFunc func;

public struct Foo {
	[CCode (delegate_target = false)]
	public FooFunc func;
	public int i;
}

public class Bar {
	[CCode (delegate_target = false)]
	public FooFunc func;
	public int i;
}

void foo_cb () {
}

const Foo[] foos = {
	{ foo_cb, 42 }
};

void main() {
	func = foo_cb;

	Foo f_stack = { foo_cb, 23 };
	Foo? f_heap = { foo_cb, 4711 };

	assert (f_stack.i == 23);
	assert (f_heap.i == 4711);
	assert (foos[0].i == 42);

	Bar b = new Bar ();
	b.func = foo_cb;
	b.i = 42;
}

