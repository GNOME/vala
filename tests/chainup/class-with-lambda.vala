public class Foo : Object {
	public Foo.lambda_after () {
		this ();
		SourceFunc f = () => this != null;
		assert (f ());
	}

	public Foo.lambda_before () {
		SourceFunc f = () => {
			SourceFunc g = () => true;
			return g ();
		};
		this ();
		assert (f ());
	}
}

void main () {
	Foo foo;
	foo = new Foo.lambda_after ();
	foo = new Foo.lambda_before ();
}
