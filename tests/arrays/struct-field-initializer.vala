[CCode (has_type_id = false)]
struct Foo {
	public unowned string[] array;
	public int i;
}

[CCode (has_type_id = false)]
public struct Bar {
	public unowned string[] array;
	public int i;
}

const string[] SARRAY = { "foo", "bar" };

const Foo FOO = { SARRAY, 23 };
const Bar BAR = { SARRAY, 42 };

void main () {
	{
		assert (FOO.array.length == 2);
		assert (FOO.i == 23);
		assert (BAR.array.length == 2);
		assert (BAR.i == 42);
	}
	{
		const Foo foo = { SARRAY, 23 };
		const Bar bar = { SARRAY, 42 };
		assert (foo.array.length == 2);
		assert (foo.i == 23);
		assert (bar.array.length == 2);
		assert (bar.i == 42);
	}
}
