namespace Maman {
	class Bar {
		public virtual string do_action (int i) {
			return 1;
		}
	}
	
	class SubBar : Bar {
		public override string do_action (int i) {
			return 2;
		}
	
		public static int main (int argc, string[] argv) {
			Bar bar = new SubBar ();
		
			return bar.do_action (1);
		}
	}
}
