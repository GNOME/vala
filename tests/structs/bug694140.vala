string[] colors;

[SimpleType]
[CCode (has_type_id = false)]
struct Foo : int {
	public string bar {
		get {
			return colors[(int) this];
		}
		set {
			colors[(int) this] = value;
		}
	}
}

void main () {
	colors = { "black", "red", "green", "blue" };

	Foo foo = 1;
	assert (foo.bar == "red");
	foo.bar = "white";
	assert (foo.bar == "white");
}
