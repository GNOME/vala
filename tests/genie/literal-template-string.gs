init
	var a = "test"
	var b = 100
	var c = @"$( a )$b"
	assert( c == "test100" )
