async void foo (int array_param[3]) {
    int array[] = { 23, 42 };

    assert (array.length == 2);
    assert (array[1] == 42);

    assert (array_param.length == 3);
    assert (array_param[2] == 4711);
}

void main() {
	int array[3] = { 42, 23, 4711 };
	foo.begin (array);
}
