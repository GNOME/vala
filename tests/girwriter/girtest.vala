[CCode (gir_namespace = "GirTest", gir_version = "1.0")]
namespace GirTest {
	public struct BoxedStruct {
		public int field_name;

		public BoxedStruct () {
		}

		public void inv () {
		}
	}

	[CCode (has_type_id = false)]
	public struct Struct {
		public int field_name;

		public Struct () {
		}

		public void inv () {
		}
	}

	[GIR (visible = false)]
	public struct SkippedStruct {
		public int field_name;
	}

	public const int CONSTANT_NUMBER = 42;
	public const string CONSTANT_STRING = "const ♥ utf8";

	public enum EnumTest {
		VALUE1,
		VALUE2,
		VALUE3 = 4711
	}

	[Flags]
	public enum FlagsTest {
		VALUE1,
		VALUE2,
		VALUE3
	}

	[CCode (has_type_id = false)]
	public enum PlainEnumTest {
		VALUE1,
		VALUE2,
		VALUE3 = 4711
	}

	[GIR (visible = false)]
	public enum SkippedEnum {
		VALUE1
	}

	[GIR (visible = false)]
	public enum SkippedFlags {
		VALUE1
	}

	public errordomain ErrorTest {
		FAILED,
		SMELLY,
		FISHY = 23
	}

	public interface InterfaceTest : Object {
		public abstract int property { get; construct set; }
		public virtual void int8_in (int8 param) {
		}
		public virtual async void coroutine_async () {
		}
		public virtual void method_valist (int param, va_list vargs) {
		}
		[GIR (visible = false)]
		public virtual async void skipped_coroutine_method (int param) {
		}
		[NoWrapper]
		public virtual void no_wrapper_method () {
		}
		[NoWrapper]
		public virtual async void no_wrapper_method_async () {
		}
		public virtual void method_implicit_params (int[] param1, owned DelegateTest param2) {
		}
		[HasEmitter]
		public signal void some_signal (int param);
		public static void static_method () {
		}
	}

	[GIR (visible = false)]
	public interface SkippedInterface {
	}

	public delegate bool DelegateTest (void* a, void* b);

	public delegate bool DelegateErrorTest () throws ErrorTest;

	public delegate bool DelegateGenericsTest<G,T> (G g, T t);

	[GIR (visible = false)]
	public delegate void SkippedDelegate ();

	public class TypeTest {
		public string some_property { get; set; }
	}

	public class SubTypeTest : TypeTest {
		public string[] array_field;
		public DelegateTest delegate_field;
	}

	public class ObjectTest : Object {
		private static ObjectTest global_instance = new ObjectTest ();

		public signal void some_signal (int param);

		[GIR (visible = false)]
		public signal void skipped_signal (int param);

		public int field = 42;

		public int fixed_array_field[23];

		public string? nullable_field;

		public string some_property { get; construct set; }

		public string write_only_property { set; }

		public string construct_only_property { construct; }

		[GIR (visible = false)]
		public string skipped_property { get; construct set; }

		public ObjectTest () {
		}
		public ObjectTest.with_int (int param) {
			field = param;
		}
		public ObjectTest.may_fail (int param) throws ErrorTest {
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

		public void string_array_out (out string[] array) {
			array = { "foo" };
		}

		public string[] string_array_return () {
			return { "foo" };
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

		public (unowned string)[] container_return () {
			return { "foo", "bar" };
		}

		public GenericArray<unowned string>? generic_array_container_return () {
			return null;
		}

		public async void coroutine_async () {
		}

		public virtual async void coroutine_virtual_async () {
		}

		public virtual async void coroutine_method_throw (int i1, out int o1) throws ErrorTest {
			o1 = i1;
		}

		public void simple_throw () throws ErrorTest {
		}

		public virtual void method_throw () throws ErrorTest {
		}

		public void method_with_default (int i = Priority.HIGH) {
		}

		public virtual signal void signal_with_default_handlder (int i1) {
		}

		[GIR (visible = false)]
		public void skipped_method () {
		}

		[NoWrapper]
		public virtual void no_wrapper_method () {
		}

		[NoWrapper]
		public virtual async void no_wrapper_method_async () {
		}

		public virtual void method_implicit_params (int[] param1, owned DelegateTest param2) {
		}
	}

	public abstract class AbstractObjectTest : Object {
		public abstract void method_int8_in (int8 param);

		public abstract void method_int8_inout (ref int8 param);

		public abstract void method_int8_out (out int8 param);

		public abstract void method_throw () throws ErrorTest;

		public abstract void method_valist (int param, va_list vargs);

		[GIR (visible = false)]
		public abstract async void skipped_coroutine_method (int param);

		[NoWrapper]
		public abstract void no_wrapper_method ();

		[NoWrapper]
		public abstract async void no_wrapper_method_async ();

		public abstract void method_implicit_params (int[] param1, owned DelegateTest param2);
	}

	public interface PrerequisiteTest : InterfaceTest {
	}

	public class ImplementionTest : Object, InterfaceTest {
		public int property { get; construct set; }
	}

	[Compact]
	public class CompactClass {
		public string s;
		public int i;
	}

	[GIR (visible = false)]
	public class SkippedClass {
	}

	[Version (deprecated = true, deprecated_since = "0.1.2", since = "0.1.0")]
	public class DeprecatedClassTest {
	}

	public class GenericsTest<G,T> {
		public GenericsTest (owned DelegateTest cb) {
		}

		public GenericsTest.typed (owned DelegateGenericsTest<G,T> cb) {
		}

		public void method (T param) {
		}
	}

	public class GenericsObjectTest<G,T> : Object {
		public void method<K> (K[] param) {
		}
	}

	namespace Nested {
		public void function () {
		}
	}
}

public enum InvalidEnum {
	VALUE
}

public errordomain InvalidError {
	FAILED
}

public class InvalidClass {
}

public interface InvalidIface {
}

public struct InvalidStruct {
	public int i;
}

public delegate void InvalidFunc ();

public const int INVALID_CONST = 0;

public int invalid_field;

public void invalid_method () {
}
