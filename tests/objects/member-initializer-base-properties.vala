interface IFoo {
	public abstract string prop { get; set; }
}

class Bar {
	public virtual string prop_v { get; set; }
}

class Foo : Bar, IFoo {
	public string prop { get; set; }
	public override string prop_v { get; set; }
}

void main() {
	var foo = new Foo () {
		prop = "bar",
		prop_v = "bar"
	};
}
