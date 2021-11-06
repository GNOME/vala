def test() raises IOError, Error
	raise new IOError.FAILED( "failed" )

init
	a:int = 0
	try
		a++
		test()
	except e:Error
		a++
	finally
		a++
	assert( a == 3 )
