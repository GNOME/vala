// --pkg cairo
void cairo_path_test (Cairo.Path path) {
	var x = path.data[0].point.x;
	var y = path.data[0].point.y;
	var type = path.data[0].header.type;
	var length = path.data[0].header.length;
}
void main() {
}

