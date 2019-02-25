init
	if false
		assert_not_reached()
	else if true
		assert( true )
		return
	assert_not_reached()
