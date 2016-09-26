public abstract class Foo : Object {
	public abstract void test<T> (T parameter);
}

public class Bar : Foo {
	public override void test<T> (T parameter) {
		stdout.printf ("Just a test!\n");
	}
}

int main () {
	var obj = new Bar();
	obj.test<string> ("test");
	return 0;
}
