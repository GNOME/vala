int BUFFER_LENGTH = 1048576;

void main () {
	// Some reasonably sized memory block
	void* buffer_p = malloc (BUFFER_LENGTH);
	Memory.set (buffer_p, 0x55555555, BUFFER_LENGTH);
	unowned uint8[] buffer = (uint8[]) buffer_p;
	buffer.length = BUFFER_LENGTH;

	// Serialize
	Variant v = buffer;

	// Deserialize
	var result = (uint8[]) v;

	assert (Memory.cmp (buffer, result, BUFFER_LENGTH) == 0);
	free (buffer_p);
}
