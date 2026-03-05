void main () {
	{
		char c = '4';
		var s = c.isalpha () ? "?" : (c.isdigit () ? "7" : c.to_string ());
		assert (s == "7");
	}
	{
		char c = '4';
		string r = "3";
		unowned var s = c.isalpha () ? "?" : (!c.isdigit () ? "7" : r);
		assert (s == "3");
	}
}
