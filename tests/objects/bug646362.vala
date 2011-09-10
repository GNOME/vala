public class Foo : Object {
	int bar;
	~Foo() {
		var baz = bar;
		SourceFunc f = () => baz == 2;
	}
}

void main () { }
