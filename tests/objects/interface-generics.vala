interface IFoo<G> : Object {
	public abstract G get ();
}

class Foo<G> : Object, IFoo<G> {
	public new G get () {
		return null;
	}
}

void main() {
}
