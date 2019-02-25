init
#if TEST && FOO
	assert_not_reached()
#else
	assert( true )
#endif
