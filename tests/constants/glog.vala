void main () {
	assert (Log.FILE.has_suffix ("glog.vala"));
	assert (Log.LINE == 3);
	assert (Log.METHOD == "main");
}
