Value get_value (Value v) {
    return v;
}

Value? get_nullable_value (Value? v) {
    return v;
}

void main () {
	{
		Value v = Value (typeof (int));
		v.set_int (42);
		if (v == 42) {
		} else {
			assert_not_reached ();
		}
		if (42 == v) {
		} else {
			assert_not_reached ();
		}
	}
	{
		Value? v = Value (typeof (int));
		v.set_int (42);
		if (v == 42) {
		} else {
			assert_not_reached ();
		}
		if (42 == v) {
		} else {
			assert_not_reached ();
		}
	}
	{
		Value v = Value (typeof (string));
		v.set_string ("foo");
		if (v == "foo") {
		} else {
			assert_not_reached ();
		}
		if ("foo" == v) {
		} else {
			assert_not_reached ();
		}
	}
	{
		Value? v = Value (typeof (string));
		v.set_string ("foo");
		if (v == "foo") {
		} else {
			assert_not_reached ();
		}
		if ("foo" == v) {
		} else {
			assert_not_reached ();
		}
	}
	{
		Value v = Value (typeof (int));
		v.set_int (23);
		if (get_value (v) != 23) {
			assert_not_reached ();
		}
		if (23 != get_value (v)) {
			assert_not_reached ();
		}
	}
	{
		Value? v = Value (typeof (int));
		v.set_int (23);
		if (get_nullable_value (v) != 23) {
			assert_not_reached ();
		}
		if (23 != get_nullable_value (v)) {
			assert_not_reached ();
		}
	}
	{
		Value v = Value (typeof (string));
		v.set_string ("bar");
		if (get_value (v) != "bar") {
			assert_not_reached ();
		}
		if ("bar" != get_value (v)) {
			assert_not_reached ();
		}
	}
	{
		Value? v = Value (typeof (string));
		v.set_string ("bar");
		if (get_nullable_value (v) != "bar") {
			assert_not_reached ();
		}
		if ("bar" != get_nullable_value (v)) {
			assert_not_reached ();
		}
	}
}
