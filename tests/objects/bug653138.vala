public class Foo {
	public SourceFunc foo { private set; get; }

	public void bar () {
		foo = null;
	}
}

void main() {
}
