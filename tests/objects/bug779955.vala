public class Foo : Object {
	int i = 42;

	public int bar {
		get {
			return i;
		}
		set {
			if (value == 42) {
				i = 23;
			}
		}
	}
}

void main () {
	var f = new Foo ();
	f.bar = 42;
	assert (f.bar == 23);
}
