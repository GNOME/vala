void main () {
	{
		var pipe = Posix.FILE.popen ("sleep 0", "r");
		var result = pipe.close ();
		assert (result == 0);
	}
	{
		new Posix.CommandPipe ("ls *");
	}
}
