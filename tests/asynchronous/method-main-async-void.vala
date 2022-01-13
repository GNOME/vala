async void main (string[] args) {
	Idle.add (main.callback);
	yield;
}
