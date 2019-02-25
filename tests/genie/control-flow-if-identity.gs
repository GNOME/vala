init
	a:string = "test"
	if a == "test"
		assert( a == "test" )
		return
	assert_not_reached()
