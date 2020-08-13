int field;

void main () {
	// incrementing
	{
		field = 1;
		int res = field + field++;
		assert (res == 2);
		assert (field == 2);
	}
	{
		field = 1;
		int res = field++ + field;
		assert (res == 3);
		assert (field == 2);
	}
	{
		field = 1;
		int res = field + ++field;
		assert (res == 3);
		assert (field == 2);
	}
	{
		field = 1;
		int res = ++field + field;
		assert (res == 4);
		assert (field == 2);
	}
	{
		field = 1;
		assert (field++ == 1);
		assert (field == 2);
	}
	{
		field = 1;
		assert (++field == 2);
		assert (field == 2);
	}

	// decrementing
	{
		field = 1;
		int d = field + field--;
		assert (d == 2);
		assert (field == 0);
	}
	{
		field = 1;
		int res = field-- + field;
		assert (res == 1);
		assert (field == 0);
	}
	{
		field = 1;
		int res = field + --field;
		assert (res == 1);
		assert (field == 0);
	}
	{
		field = 1;
		int res = --field + field;
		assert (res == 0);
		assert (field == 0);
	}
	{
		field = 1;
		assert (field-- == 1);
		assert (field == 0);
	}
	{
		field = 1;
		assert (--field == 0);
		assert (field == 0);
	}
}
