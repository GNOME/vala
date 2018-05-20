[GIR (gir_namespace = "GirTest", gir_version = "1.0")]
namespace GirTest {
	public struct BoxedStruct {
		public int field_name;

		public BoxedStruct () {
		}

		public void inv () {
		}
	}

	[GIR (visible = false)]
	public class SkippedStruct {
	}

	public const int CONSTANT_NUMBER = 42;
	public const string CONSTANT_STRING = "const ♥ utf8";

	public enum EnumTest {
		VALUE1,
		VALUE2,
		VALUE3
	}

	[Flags]
	public enum FlagsTest {
		VALUE1,
		VALUE2,
		VALUE3
	}

	[GIR (visible = false)]
	public enum SkippedEnum {
		VALUE1
	}

	[GIR (visible = false)]
	public enum SkippedFlags {
		VALUE1
	}

	public interface InterfaceTest {
		public virtual void int8_in (int8 param) {
		}
	}

	[GIR (visible = false)]
	public interface SkippedInterface {
	}

	public delegate bool DelegateTest (void* a, void* b);

	[GIR (visible = false)]
	public delegate void SkippedDelegate ();

	public class ObjectTest : Object {
		private static ObjectTest global_instance = new ObjectTest ();

		public signal void some_signal (int param);

		[GIR (visible = false)]
		public signal void skipped_signal (int param);

		public int field = 42;
		public ObjectTest () {
		}
		public ObjectTest.with_int (int param) {
			field = param;
		}
		public ObjectTest.newv (int param, ...) {
			field = param;
		}
		public ObjectTest.new_valist (int param, va_list vargs) {
			field = param;
		}
		public static void full_inout (ref ObjectTest obj) {
			assert (obj.field == 42);
			obj = new ObjectTest ();
		}
		public static void full_out (out ObjectTest obj) {
			obj = new ObjectTest ();
		}
		public static ObjectTest full_return () {
			return new ObjectTest ();
		}
		public static void none_inout (ref unowned ObjectTest obj) {
			assert (obj.field == 42);
			obj = global_instance;
		}
		public static void none_out (out unowned ObjectTest obj) {
			obj = global_instance;
		}
		public static unowned ObjectTest none_return () {
			return global_instance;
		}

		public static void static_method () {
		}

		public virtual void method_with_default_impl (int8 param) {
		}

		public void int8_in (int8 param) {
		}

		public void int8_out (out int8 param) {
			param = 42;
		}

		public void method () {
		}

		public void method_varargs (int param, ...) {
		}

		public void method_valist (int param, va_list vargs) {
		}

		public void array_in (int[] array) {
		}

		public void array_inout (ref int[] array) {
			assert (array.length > 0);
			array = new int[8];
		}

		public void array_out (out int[] array) {
			array = new int[8];
		}

		public int[] array_return () {
			return new int[8];
		}

		public void int_in_int_in_array_out (int param1, int param2, out int[] array) {
			array = new int[8];
		}

		public int[] int_in_int_in_array_return (int param1, int param2) {
			return new int[8];
		}

		public void none_in () {
		}

		public DelegateTest delegate_return () {
			return (val1, val2) => { return (void*)val1 == (void*)val2; };
		}

		public DelegateTest delegate_return_int_in_array_out (int i1, out int[] a) {
			a = new int[8];
			return delegate_return ();
		}

		public int[] array_return_int_in_delegate_out (int i1, out DelegateTest d) {
			d = delegate_return ();
			return new int[8];
		}

		public EqualFunc simple_delegate_return () {
			return str_equal;
		}

		[GIR (visible = false)]
		public void skipped_method () {
		}
	}

	public abstract class AbstractObjectTest : Object {
		public abstract void method_int8_in (int8 param);

		public abstract void method_int8_inout (ref int8 param);

		public abstract void method_int8_out (out int8 param);
	}

	[GIR (visible = false)]
	public class SkippedClass {
	}
}
