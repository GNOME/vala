namespace Maman {
	class Bar {
		public int do_action (int i) {
			return (i + 42);
		}
	}
	
	class SubBar : Bar {
		void init () {
			do_action (42);
		}
	
		public static int main (int argc, string[] argv) {
			SubBar subbar = new SubBar ();
		
			int i;
			int j;
			
			for (i = 0; i < argc; i++) {
				subbar.do_action (i);
			}
			
			if (i == 1) {
				j = 42;
			} else {
				j = argc;
			}
			
			return (i * j);
		}
	}
}
