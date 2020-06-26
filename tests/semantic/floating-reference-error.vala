[CCode (returns_floating_reference = true)]
Variant? get_floating_variant_with_error () throws Error {
	return new Variant.string ("bar");
}

void variant_args (int first, ...) {
	var va = va_list ();
	assert (!va.arg<Variant> ().is_floating ());
}

void main () {
	{
		variant_args (23, get_floating_variant_with_error ());
	}
	{
		try {
			variant_args (42, get_floating_variant_with_error ());
		} catch {
			assert_not_reached ();
		}
	}
}
