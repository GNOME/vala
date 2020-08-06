public enum FooEnum {
	VALUE1,
	VALUE2;
}

[Flags]
public enum FooFlag {
	VALUE1,
	VALUE2;
}

[CCode (has_type_id = false)]
public enum BarEnum {
	VALUE1,
	VALUE2;
}

[Flags]
[CCode (has_type_id = false)]
public enum BarFlag {
	VALUE1,
	VALUE2;
}

public class Manam {
	public FooEnum prop1 { get; set; }
	public FooFlag prop2 { get; set; }
	public BarEnum prop3 { get; set; }
	public BarFlag prop4 { get; set; }
}

public class Minim : Object {
	public FooEnum prop1 { get; set; }
	public FooFlag prop2 { get; set; }
	public BarEnum prop3 { get; set; }
	public BarFlag prop4 { get; set; }
}

void main () {
	{
		var manam = new Manam ();
		manam.prop1 = FooEnum.VALUE2;
		assert (manam.prop1 == FooEnum.VALUE2);
		manam.prop2 = FooFlag.VALUE2;
		assert (manam.prop2 == FooFlag.VALUE2);
		manam.prop3 = BarEnum.VALUE2;
		assert (manam.prop3 == BarEnum.VALUE2);
		manam.prop4 = BarFlag.VALUE2;
		assert (manam.prop4 == BarFlag.VALUE2);
	}
	{
		var minim = new Minim ();
		minim.prop1 = FooEnum.VALUE2;
		assert (minim.prop1 == FooEnum.VALUE2);
		minim.prop2 = FooFlag.VALUE2;
		assert (minim.prop2 == FooFlag.VALUE2);
		minim.prop3 = BarEnum.VALUE2;
		assert (minim.prop3 == BarEnum.VALUE2);
		minim.prop4 = BarFlag.VALUE2;
		assert (minim.prop4 == BarFlag.VALUE2);
	}
}
