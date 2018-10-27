[DBus (use_string_marshalling = true)]
public enum FooEnum {
	BAR
}

[DBus (name = "org.example.Test")]
public interface Test : GLib.Object {
	public abstract async void test1 (FooEnum e) throws DBusError;
	public abstract void test2 (FooEnum e) throws DBusError;
	public abstract void test3 (FooEnum e1, int fd, FooEnum e2) throws DBusError;
	public abstract void test4 (FooEnum e);
	public abstract async void test5 (FooEnum e);
}

void main () {
	// We just want to ensure compile correctness here
}
