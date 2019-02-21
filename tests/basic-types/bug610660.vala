void main () {
	{
		double d = 42.0;
		d = d % 42.0;
		assert (d == 0.0);
	}
	{
		double d = 23.0;
		d %= 23.0;
		assert (d == 0.0);
	}
	{
		float f = 42.0f;
		f = f % 42.0f;
		assert (f == 0.0f);
	}
	{
		float f = 23.0f;
		f %= 23.0f;
		assert (f == 0.0f);
	}
}
