[CCode (has_type_id = false)]
public struct FooStruct {
	public uint8 i;
	public string s;
}

void main () {
	{
		FooStruct array[2];
		array[0] = { 23, "foo"};
		array[1] = { 42, "bar"};
	}
	{
		GLib.Value array[2];
		array[0].init (typeof (int));
		array[1].init (typeof (string));
	}
}
