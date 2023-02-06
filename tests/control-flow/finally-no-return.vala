void foo () throws Error {
}

[NoReturn]
void bar () {
}

void main () {
	try {
		foo ();
	} finally {
		bar ();
	}
}
