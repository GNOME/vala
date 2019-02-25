init
	result:string = ""
#if VALA_0_16
	result = "0.16+"
#else
	result = "<0.16"
#endif

	assert( result != "" )

#if VALA_0_16
	assert( result == "0.16+" )
#else
	assert( result == "<0.16" )
#endif
