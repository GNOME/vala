struct Foo {
	public const int FOO = 23;

	public static Foo static_field;
	public int i;
}

const int BAR = Foo.static_field.FOO;

void main () {
	assert (BAR == 23);
}
