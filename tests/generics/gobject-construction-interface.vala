[GenericAccessors]
interface IFoo<T> : Object {
	public abstract T foo { get; set; }
	public Type get_foo_type () {
		return typeof (T);
	}
}

abstract class Foo<T> : Object, IFoo<T> {
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
	assert (bar.get_foo_type () == typeof (string));
}
