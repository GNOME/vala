namespace FastVapi {
	public const int CONSTANT = 42;

	public enum EnumTest {
		VALUE
	}

	public errordomain ErrorTest {
		FAILED
	}

	public struct TestStruct {
		public int field_name;
	}

	public interface InterfaceTest : Object {
		public abstract int property { get; construct set; }
		public abstract void method (int param);
	}

	public delegate bool DelegateTest (int param);

	public class Test : Object {
		public signal void some_signal (int param);

		public int field;

		public string property { get; construct set; }

		public Test () {
		}

		public void method () {
		}
	}
}
