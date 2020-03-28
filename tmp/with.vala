class Foo {
	public int field;
	public string prop { get; set; }
}


void main() {
	var foo = new Foo();
	var test = 0;
	var field = 13;
    with(foo) {
		//this.field = 15;
		field = 42;
		prop = "foo";
		test = 10;
	};
	stdout.printf("foo.field=%i foo.prop=%s field=%i test=%i\n", foo.field, foo.prop, field, test);
} 
