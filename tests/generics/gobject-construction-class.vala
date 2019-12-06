abstract class Foo<T> : Object {
	public T foo { get; set; }
}

class Bar : Foo<string> {
}

void main () {
	Bar bar;
	{
		string foo = "foo";
		bar = (Bar) Object.new (typeof (Bar), "foo", foo);
	}
	assert (bar.foo == "foo");
}
