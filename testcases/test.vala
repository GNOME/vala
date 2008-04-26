
using GLib;





public int GlobalTestfunktion () { return 0; }
public delegate int GlobalTestDelegate ( );

namespace Foo {
	public delegate int DelegateInFoo ( );
	public int FieldInFoo;

	public int MethodInFoo ( int bar ) {
		return 0;
	}

	namespace BARAKUDA {
		/**
		 * { @link Foo.BARAKUDA }
		 * { @link MethodInBarakuda }
		 * { @link Foo.BARAKUDA.MethodInBarakuda }
		 */
		public delegate int DelegateInBARAKUDA ( );

		public int MethodInBarakuda ( ) {
			return 0;
		}

		namespace BAR2 {
			public enum EnumInBarD {

			}

			public errordomain ErrorDomainInBarD {
				ErrorValueInErrorDomainInBarD;

				public void MethodInErrorDomainInBarD ( ) {
				}
			}

			public struct StructInBarD {
				public int FieldInStruct;
				public int MethodInStruct () {
					return 0;
				}

				public StructInBarD.ConstructionMethod () {
				}
			}

			public interface InterfaceInBarD {
				public int MethodInInterface (  ) {
					return 0;
				}

				public signal int SignalInInterface ( int foo );

				public abstract int PropertyInInterface { get; set; }
			}

			public class SuperInBarD : Object {
				public SuperInBarD.construction ( ) {
				}

				public int SuperInBarDProperty {
					get; set;
				}

				public struct SuperInBarDStruct {
					/**
					 * { @link this.SuperIntBarDStructField }
					 */
					public int SuperIntBarDStructField;
					public int SuperIntBarDStructField2;
					public int SuperIntBarDStructField3;

					public int SuperIntBarDStructMethod (  ) {
						return 0;
					}

					public SuperInBarDStruct.construction ( ) {
					}
				}
				/*
				 * { @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDStruct.SuperIntBarDStructField }
				 */
				public signal int SuperInBarDSignal ( );
				public int SuperInBarDField;

				public int SuperInBarDMethod ( ) {
					return 0;
				}
			}
		}




		/**
		 * <br>{ @link Foo.BARAKUDA.BAR2.StructInBarD.MethodInStruct }  
		 * <br>{ @link Foo.BARAKUDA.BAR2.StructInBarD.FieldInStruct }
		 * <br>{ @link Foo.BARAKUDA.BAR2.StructInBarD.StructInBarD.ConstructionMethod }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarD.construction }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDProperty }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDSignal }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDMethod }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDField }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDStruct.SuperInBarDStruct.construction }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDStruct.SuperIntBarDStructMethod }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD.SuperInBarDStruct }
		 * <br>{ @link Foo.BARAKUDA.BAR2.InterfaceInBarD.PropertyInInterface }
		 * <br>{ @link Foo.BARAKUDA.BAR2.InterfaceInBarD.MethodInInterface }
		 * <br>{ @link Foo.BARAKUDA.BAR2.InterfaceInBarD.SignalInInterface }
		 * <br>{ @link Foo.BARAKUDA.BAR2.InterfaceInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2.StructInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2.ErrorDomainInBarD.MethodInErrorDomainInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2.ErrorDomainInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2.ErrorDomainInBarD.ErrorValueInErrorDomainInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2.EnumInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2.SuperInBarD }
		 * <br>{ @link Foo.BARAKUDA.BAR2 }
		 * <br>{ @link Foo.BARAKUDA.SuperInBar.SuperInSubBar }
		 * <br>{ @link Foo.BARAKUDA.SuperInBar.SuperInSubBar.SuperInSubBarMethod }
		 * <br>{ @link Foo.BARAKUDA.SuperInBar.SuperInSubBar.SuperInSubSubBar.SuperInSubSubBarMethod }
		 * <br>{ @link Foo.BARAKUDA.DelegateInBARAKUDA }
		 * <br>{ @link Foo.BARAKUDA.SuperInBar }
		 * <br>{ @link Foo.BARAKUDA }
		 * <br>{ @link Foo.DelegateInFoo }
		 * <br>{ @link Foo.MethodInFoo }
		 * <br>{ @link Foo.SuperInFoo }
		 * <br>{ @link Foo.FieldInFoo }
		 * <br>{ @link Foo }
		 */
		public class SuperInBar : Object {
			public class SuperInSubBar : Object {
				public class SuperInSubSubBar : Object {
					public int SuperInSubSubBarMethod () { return 0; }
				}

				public int SuperInSubBarMethod () { return 0; }
			}

			public int bar;
			public int foo () { return 0; }
			public signal int barfoo ( int foo );
			public int foobar { get; set; }
		}
	}

		/*
 		 * { @link GlobalTestDelegate }
 		 * { @link GlobalTestfunktion }
		 */
	public class SuperInFoo : Object {
		public class Foo : Object {
			public int bar;
			public int foo () { return 0; }
			public signal int barfoo ( int foo );
			public int foobar { get; set; }
		}

		public int bar;
		public int foo () { return 0; }
		public signal int barfoo ( int foo );
		public int foobar { get; set; }
	}
}
