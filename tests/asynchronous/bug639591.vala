delegate void Deleg ();

async void foo (Deleg deleg)
{
	Deleg d = () => { deleg (); };
	d = null;
}

void main() {
}
