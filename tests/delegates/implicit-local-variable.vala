void main () {
	SourceFuncs foo = { null, null, () => { return false; }, null };
	Source bar = null;

	foo.dispatch (bar, null);
}
