void main () {
	{
		int x = 23, y = 42;
		int foo () {
			return x + y;
		}
		assert (foo () == 65);
	}
	{
		bool foo (int a, int b) {
			assert (a * b == 966);
			return true;
		}
		assert (foo (23, 42));
	}
	{
		void foo (out string s) {
			s = "foo";
		}
		string s;
		foo (out s);
		assert (s == "foo");
	}
	{
		unowned string foo (ref string s) {
			assert (s == "foo");
			s = "bar";
			return s;
		}
		string s = "foo";
		assert (foo (ref s) == "bar");
		assert (s == "bar");
	}
}
