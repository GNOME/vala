struct Manam {
	string s;
}

string[] foo;
int[] bar;
Manam[] manam;

string[] get_foo () {
	return foo;
}

int[] get_bar () {
	return bar;
}

Manam[] get_manam () {
	return manam;
}

void main () {
	{
		foo = new string[0];
		assert (foo != null);
		assert (get_foo () != null);
	}
	{
		foo = {};
		assert (foo != null);
		assert (get_foo () != null);
	}
	{
		bar = new int[0];
		//assert (bar != null);
		assert (get_bar () == null);
	}
	{
		bar = {};
		//assert (bar != null);
		assert (get_bar () == null);
	}
	{
		manam = new Manam[0];
		//assert (manam != null);
		assert (get_manam () == null);
	}
	{
		manam = {};
		//assert (manam != null);
		assert (get_manam () == null);
	}
}
