void main () {
	{
		Mutex mutex = Mutex ();
		mutex.lock ();
		assert (!mutex.trylock ());
		mutex.unlock ();
	}
	{
		RecMutex mutex = RecMutex ();
		mutex.lock ();
		assert (mutex.trylock ());
		mutex.unlock ();
		mutex.unlock ();
	}
}
