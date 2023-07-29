[CCode (no_generic_args = true)]
public void foo<G> () where G : string {
}

void main () {
	foo<string> ();
}
