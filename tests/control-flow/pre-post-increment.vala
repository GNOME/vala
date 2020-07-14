void main () {
	{
		int i = 0;
		i = i++ + 1;
		assert (i == 1);
	}
	{
		int i = 0;
		assert (i++ == 0);
	}
	{
		int i = 0;
		i = ++i + 1;
		assert (i == 2);
	}
	{
		int i = 0;
		assert (++i == 1);
	}
}

