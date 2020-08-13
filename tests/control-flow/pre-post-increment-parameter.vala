void test_parameter (int parameter) {
	// incrementing
	{
		parameter = 1;
		int res = parameter + parameter++;
		assert (res == 2);
		assert (parameter == 2);
	}
	{
		parameter = 1;
		int res = parameter++ + parameter;
		assert (res == 3);
		assert (parameter == 2);
	}
	{
		parameter = 1;
		int res = parameter + ++parameter;
		assert (res == 3);
		assert (parameter == 2);
	}
	{
		parameter = 1;
		int res = ++parameter + parameter;
		assert (res == 4);
		assert (parameter == 2);
	}
	{
		parameter = 1;
		assert (parameter++ == 1);
		assert (parameter == 2);
	}
	{
		parameter = 1;
		assert (++parameter == 2);
		assert (parameter == 2);
	}

	// decrementing
	{
		parameter = 1;
		int res = parameter + parameter--;
		assert (res == 2);
		assert (parameter == 0);
	}
	{
		parameter = 1;
		int res = parameter-- + parameter;
		assert (res == 1);
		assert (parameter == 0);
	}
	{
		parameter = 1;
		int res = parameter + --parameter;
		assert (res == 1);
		assert (parameter == 0);
	}
	{
		parameter = 1;
		int res = --parameter + parameter;
		assert (res == 0);
		assert (parameter == 0);
	}
	{
		parameter = 1;
		assert (parameter-- == 1);
		assert (parameter == 0);
	}
	{
		parameter = 1;
		assert (--parameter == 0);
		assert (parameter == 0);
	}
}

void main () {
	test_parameter (1);
}
