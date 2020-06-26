[CCode (returns_floating_reference = true)]
Variant get_floating_variant () {
	return new Variant.string ("foo");
}

[CCode (returns_floating_reference = true)]
Variant? get_floating_variant_with_error () throws Error {
	return new Variant.string ("bar");
}

void test_variant () {
	{
		string? @value = "bar";
		Variant? variant = new Variant.string (@value) ?? new Variant.string (@value);
		assert (variant.is_of_type (VariantType.STRING));
		assert (!variant.is_floating ());
	}
	{
		string? @value = "foo";
		Variant? variant = @value == null ? null : new Variant.string (@value);
		assert (variant.is_of_type (VariantType.STRING));
		assert (!variant.is_floating ());
	}
	{
		string? @value = "foo";
		Variant? variant;
		if (@value == null) {
			variant = null;
		} else {
			variant = new Variant.string (@value);
		}
		assert (variant.is_of_type (VariantType.STRING));
		assert (!variant.is_floating ());
	}
	{
		bool @value = true;
		Variant? variant = new Variant.boolean (@value);
		assert (variant.is_of_type (VariantType.BOOLEAN));
		assert (!variant.is_floating ());
	}
	{
		string? @value = "manam";
		Variant? variant = new Variant.string (@value);
		assert (variant.is_of_type (VariantType.STRING));
		assert (!variant.is_floating ());
		string s = (string) variant;
		assert (s == "manam");
	}
	{
		Variant? variant = get_floating_variant ();
		assert (!variant.is_floating ());
	}
	{
		Variant? variant = get_floating_variant_with_error ();
		assert (!variant.is_floating ());
	}
	{
		try {
			Variant? variant = get_floating_variant_with_error ();
			assert (!variant.is_floating ());
		} catch {
			assert_not_reached ();
		}
	}
}

void test_variant_builder () {
	string name = "foo";
	string key = "bar";
	Variant? @value = null;
	var builder = new VariantBuilder (new VariantType ("a{smv}"));
	builder.add ("{smv}", key, @value);
	var variant = new Variant ("(s@a{smv})", name, builder.end ());
	assert (!variant.is_floating ());
}

void main () {
	test_variant ();
	test_variant_builder ();
}
