class Foo {
	public int field;
	public string prop { get; set; }

	//  public void print() {
	//  	lock(field) {
	//  		stdout.printf("Print");
	//  	}
	//  }
}


void main() {
	var foo = new Foo();
	//  foo.print();
	//foo.field = 0;
    with(foo) {
		field = 42;
		prop = "foo";
	};
	stdout.printf("foo: field=%i prop=%s", foo.field, foo.prop);
} 
