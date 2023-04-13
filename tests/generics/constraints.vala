class Base {
}

[GenericAccessors]
interface IFoo<G> where G : Base {
	public abstract G get (G g);
}

class Foo<T> : IFoo where T : Base {
	public Base @get (Base g) {
		return null;
	}
	public T @set (T t) {
		return null;
	}
}

class Bar<T> : IFoo where T : G {
	public Base @get (Base g) {
		return null;
	}
	public T @set (T t) {
		return null;
	}
}

class Manam : Foo {
}

delegate R FooFunc<R> (R r) where R : Base;

S bar<S> (S s = null) where S : Base {
	return null;
}

void main () {
	var foo = new Foo ();
	var faz = new Bar ();
	var manam = new Manam ();
	FooFunc func = () => { return null; };
	bar ();
}
