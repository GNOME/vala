delegate unowned uint8[:uint64] FooFunc (uint8[:size_t] param0, ref uint8[:int64] param1, out uint8[:uint] param2, uint8 param3[42:ssize_t]);

unowned uint8[:uint64] func (uint8[:size_t] param0, ref uint8[:int64] param1, out uint8[:uint] param2, uint8 param3[42:ssize_t]) {
	return param0;
}

uint8[:ssize_t] field0;
uint8 field1[4711:ssize_t];

void main () {
	var local_heap = new uint8[23:ssize_t];
	uint8 local_stack[42:ssize_t];
}
