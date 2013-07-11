[CCode (scope = "async")]
public delegate void Run();

static void eval(owned Run run) {
	Run own = (owned) run;
	own ();
}

void main() {
	int i = 0;
	eval(() => {
		i++;
	});
	assert(i == 1);
}
