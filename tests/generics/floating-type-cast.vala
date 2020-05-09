void foo<G,T> (G g, T t) {
	assert ((float?) g == 23.0f);
	assert ((double?) t == 42.0);
}

void main () {
	foo ((float?) 23.0f, (double?) 42.0);
	foo<float?,double?> ((float?) 23.0f, (double?) 42.0);
}
