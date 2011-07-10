async void foo<T>() { }

async void bar () {
	yield foo<int> ();
}

void main () {
}
