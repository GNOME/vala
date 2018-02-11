[DBus (name = "org.example.IFoo")]
public interface IFoo : Object {
	public abstract void method0 () throws Error;
	public abstract void method1 () throws DBusError, IOError;
	[DBus (visible = false)]
	public abstract void method2 ();
}

[DBus (name = "org.example.Foo")]
public class Foo : Object {
	public void method0 () throws Error {
	}
	public void method1 () throws DBusError, IOError {
	}
	[DBus (visible = false)]
	public void method2 () {
	}
}

void main () {
}
