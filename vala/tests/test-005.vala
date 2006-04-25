namespace Maman {
	class Bar {
		public static int do_action (int i) {
			return (i + 42);
		}
	}
	
	class SubBar : Bar {
		public static int main (int argc, string[] argv) {
			int i = do_action (42);
			return (argc + i);
		}
	}
}
