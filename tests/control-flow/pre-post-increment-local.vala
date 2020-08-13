void main () {
	// incrementing
	{
		int local = 1;
		int res = local + local++;
		assert (res == 2);
		assert (local == 2);
	}
	{
		int local = 1;
		int res = local++ + local;
		assert (res == 3);
		assert (local == 2);
	}
	{
		int local = 1;
		int res = local + ++local;
		assert (res == 3);
		assert (local == 2);
	}
	{
		int local = 1;
		int res = ++local + local;
		assert (res == 4);
		assert (local == 2);
	}
	{
		int local = 1;
		assert (local++ == 1);
		assert (local == 2);
	}
	{
		int local = 1;
		assert (++local == 2);
		assert (local == 2);
	}

	// decrementing
	{
		int local = 1;
		int res = local + local--;
		assert (res == 2);
		assert (local == 0);
	}
	{
		int local = 1;
		int res = local-- + local;
		assert (res == 1);
		assert (local == 0);
	}
	{
		int local = 1;
		int res = local + --local;
		assert (res == 1);
		assert (local == 0);
	}
	{
		int local = 1;
		int res = --local + local;
		assert (res == 0);
		assert (local == 0);
	}
	{
		int local = 1;
		assert (local-- == 1);
		assert (local == 0);
	}
	{
		int local = 1;
		assert (--local == 0);
		assert (local == 0);
	}
}
