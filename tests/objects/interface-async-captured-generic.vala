[GenericAccessors]
interface IFoo<G> : Object {
	public async void bar (G g) {
		assert (typeof (G) == typeof (string));
		assert (g == "foo");
	}
}

class Foo : Object, IFoo<string> {
}

void main () {
	var foo = new Foo ();
	foo.bar.begin ("foo");
}
