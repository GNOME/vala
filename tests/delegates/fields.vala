delegate void FooFunc ();

[CCode (has_target = false)]
delegate void FooFuncTargetless ();

FooFunc foo;
unowned FooFunc foo_unowned;
FooFuncTargetless foo_targetless;

void func () {
}

void main () {
	foo = func;
	foo_unowned = func;
	foo_targetless = func;
}
