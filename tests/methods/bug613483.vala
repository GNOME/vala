class Foo {
	int bar {
		set {
			Idle.add (() => {
				int i = value;
				return false;
			});
		}
	}
}

void main () {
}
