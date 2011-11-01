public class Foo<T> {
	public void bar () {
		T baz = null;
		SourceFunc f = () => {
			baz = null;
			SourceFunc ff = () => {
				baz = null;
				return false;
			};
			ff ();
			return false;
		};
		f ();
	}
}

void main () {
	var foo = new Foo<string> ();
	foo.bar ();
}
