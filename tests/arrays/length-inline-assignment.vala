void main () {
	{
		int[] i = { 23, 42 };
		int j = --i.length;
		assert (i.length == 1);
		assert (j == 1);
		j = ++i.length;
		assert (i.length == 2);
		assert (j == 2);
	}
	{
		int[] i = { 23, 42 };
		int j = (i.length = i.length - 1);
		assert (i.length == 1);
		assert (j == 1);
		j = (i.length = i.length + 1);
		assert (i.length == 2);
		assert (j == 2);
	}
	{
		int[] i = { 23, 42 };
		int j = i.length--;
		assert (i.length == 1);
		assert (j == 2);
		j = i.length++;
		assert (i.length == 2);
		assert (j == 1);
	}
}
