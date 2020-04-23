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

		public weak Test weak_field;

		public string property { get; construct set; }

		public weak Test weak_property { get; private set; }

		public Test.sub () {
		}

		public void method () {
		}
	}

	public struct TestSubStruct : TestStruct {
		public static int static_field_name;
	}

	public const int CONSTANT_TWO = CONSTANT;

	public enum EnumTestTwo {
		VALUE = 3,
		VALUE_TWO = VALUE,
	}

	public class TestFundamental {
		private TestFundamental () {
		}
	}

	public abstract class AbstractTest {
	}
}
