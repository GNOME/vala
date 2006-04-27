namespace Maman {
	class Bar {
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
			c = a + 5 + aa;
		}
	}
}

