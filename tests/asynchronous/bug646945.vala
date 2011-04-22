class Foo : Object {
	public virtual async void method1 () { }
}

interface Bar : Object {
	public virtual async void method2 () { }
}

class Baz : Foo, Bar {
	public override async void method1 () {
		method1.callback ();
	}

	public async void method2 () {
		method2.callback ();
	}
}

void main () {
}
