class Bar {
}

interface IFoo<G> where G : Bar {
}

class Foo<T> : Object, IFoo<T> where T : Bar {
}

struct FooStruct<T> where T : Bar {
	public T t;
}

delegate T FooFunc<T> (T t) where T : Bar;

T foo<T> (T t) where T : Bar {
	return null;
}

void main () {
}
