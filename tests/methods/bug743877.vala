void main () {
	Intl.setlocale ();

	string input_str = "Álvaro";
	string[] alternates;
	var tokens = input_str.tokenize_and_fold (null, out alternates);

	assert ("álvaro" in tokens);
	assert ("alvaro" in alternates);
}

