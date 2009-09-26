struct Foo {
        int x;
}

class Bar {
	public Foo? foo {
		set {
			bool b = (value == null);
                }
        }
}

void main () {
}
