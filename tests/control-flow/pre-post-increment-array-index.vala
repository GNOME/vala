void main () {
	char foo[4];
	foo[3] = '\0';

	var i = 0;
	foo[i++] = 'b';
	i = 0;
	foo[++i] = 'a';
	i = 2;
	foo[i++] = 'r';

	assert (i == 3);
	assert ((string) foo == "bar");
}
