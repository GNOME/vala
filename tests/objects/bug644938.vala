public abstract class Foo<TYPE_PARAM> : Object {
	public abstract void method (TYPE_PARAM o);
}

public class Bar : Foo<int> {
	public override void method (int i) {
	}
}

void main () {
	var bar = new Bar ();
}
