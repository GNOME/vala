void main () {
#if VALA_NEVER_SET_FOO
	assert_not_reached ();
#elif VALA_NEVER_SET_BAR
	assert_not_reached ();
#elif VALA_NEVER_SET_FOO && VALA_NEVER_SET_BAR
	assert_not_reached ();
#elif VALA_NEVER_SET_FOO || VALA_NEVER_SET_BAR
	assert_not_reached ();
#elif (VALA_NEVER_SET_FOO == VALA_NEVER_SET_BAR) && VALA_NEVER_SET_FOO
	assert_not_reached ();
#elif (VALA_NEVER_SET_FOO != VALA_NEVER_SET_BAR) && VALA_NEVER_SET_FOO
	assert_not_reached ();
#else
	assert (true);
#endif
}
