[Compact]
class Foo {
	public uint8[] data {
		owned get {
			return new uint8[42];
		}
	}
}

async void foo (uint8[] data) {
	assert (data.length == 42);
}

async void bar () {
	var f = new Foo ();
	foo.begin (f.data);
}

void main() {
	bar.begin ();
}
