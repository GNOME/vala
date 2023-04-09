[CCode (gir_namespace = "GirTest", gir_version = "1.0")]
namespace GirTest {
	/**
	 * An example comment for an example constant.
	 */
	public const int CONSTANT = 42;

	/**
	 * An example comment for an example function.
	 */
	public static void function () {
	}

	/**
	 * An example comment for an example struct.
	 */
	public struct StructTest {
		/**
		 * An example comment for an example field.
		 */
		public int field;
		/**
		 * An example comment for an example struct constructor.
		 *
		 * @param param An example comment for an example parameter.
		 */
		public StructTest (int param) {
		}
		/**
		 * An example comment for an example struct method.
		 *
		 * @param param An example comment for an example parameter.
		 * @return An example comment for an example return value.
		 */
		public bool method (int param) {
			return true;
		}
	}

	/**
	 * An example comment for an example enum.
	 */
	public enum EnumTest {
		VALUE1
	}

	/**
	 * An example comment for an example errordomain.
	 */
	public errordomain ErrorTest {
		VALUE1
	}

	/**
	 * An example comment for an example delegate.
	 *
	 * @param param An example comment for an example parameter.
	 * @return An example comment for an example return value.
	 */
	public delegate bool DelegateTest (int param);

	/**
	 * An example comment for an example interface.
	 */
	public interface InterfaceTest : Object {
		/**
		 * An example comment for an example interface method.
		 *
		 * @param param An example comment for an example parameter.
		 * @return An example comment for an example return value.
		 */
		public abstract bool method (int param);
	}

	/**
	 * An example comment for an example class.
	 */
	public class ObjectTest : Object {
		/**
		 * An example comment for an example property.
		 */
		public int property { get; construct set; }
		/**
		 * An example comment for an example signal.
		 *
		 * @param param An example comment for an example parameter.
		 */
		public signal void some_signal (int param);
		/**
		 * An example comment for an example class constructor.
		 *
		 * @param param An example comment for an example parameter.
		 */
		public ObjectTest (int param) {
		}
		/**
		 * An example comment for an example class method.
		 *
		 * @param param An example comment for an example parameter.
		 * @return An example comment for an example return value.
		 */
		public bool method (int param) {
			return true;
		}
	}
}
