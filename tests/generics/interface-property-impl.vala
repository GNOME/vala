interface IFoo<T> : Object {
	public abstract T data { get; set; }
}

class Foo : Object, IFoo<string> {
	public string data { get; set; }
}

class Bar : Object, IFoo<int> {
	public int data { get; set; }
}

void main () {
	{
		var foo = new Foo ();
		foo.data = "foo";
		assert (foo.data == "foo");
	}
	{
		var bar = new Bar ();
		bar.data = 42;
		assert (bar.data == 42);
	}
}
