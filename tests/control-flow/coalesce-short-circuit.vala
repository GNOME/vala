int g;

public int? hello (int i) {
	g = i;
	return i;
}

void main () {
	{
		g = 1;
		int? i = 1;
		i = i ?? hello (2);
		assert (i == 1);
		assert (g == 1);
	}
	{
		g = 1;
		int? i = 1;
		i = i ?? (hello (2) ?? 3);
		assert (i == 1);
		assert (g == 1);
	}
}
