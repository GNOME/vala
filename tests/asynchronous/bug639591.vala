delegate void Deleg ();

async void foo (owned Deleg deleg)
{
	Deleg d = () => { deleg (); };
	d = null;
}

void main() {
}
