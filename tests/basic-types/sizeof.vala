

public const size_t simple_size = sizeof (int);
public const size_t composed_size = sizeof (int) + sizeof (size_t);

static void main () {
	assert (composed_size == (sizeof (int) + sizeof (size_t)));
	assert (simple_size == sizeof (int));
}



