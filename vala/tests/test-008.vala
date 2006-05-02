namespace Maman {
	class Foo {
		public int foo_a = 5;
		public static int foo_b = 6;
	}
	class Bar : Foo {
		public int a = 1;
		private int b = 2;
		public static int c = 3;
		private static int d = 4;
		static int e = 5;
		int f = 6;
		int g;
		
		public void test () {
			int aa = 6;
			a = 3 + b;
			c = a + 5 + aa + foo_a + foo_b;
		}
	}
}

