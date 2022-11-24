init
	a:int = 101
	assert( a == 101 )

	b:int64 = 0xdeadbeef
	assert( b == 3735928559 )

	var c = 0b11111010011ll
	assert( c == 2003ll )

	var d = 0o1307u
	assert( d == 711u )

	var e = -0o110157032
	assert( e == -18931226 )
