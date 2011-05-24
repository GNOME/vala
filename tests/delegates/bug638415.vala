[CCode (array_length = false)]
public delegate string[] Deleg ();

string[] foo () {
	return new string[0];
}

void main () {
	Deleg bar = foo;
	bar ();
}

