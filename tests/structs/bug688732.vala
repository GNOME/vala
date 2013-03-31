struct Foo<T> {
	public T t;
}

struct Bar : Foo<Bar> {
}

void main () {
}
