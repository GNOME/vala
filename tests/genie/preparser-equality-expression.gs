init
#if THIS_IS_NOT_SET == true
	assert_not_reached()
#else
	assert( true )
#endif
