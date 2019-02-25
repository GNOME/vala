init
	a:int = 2

	a += 1
	assert( a == 3 )

	a -= 1
	assert( a == 2 )

	a /= 2
	assert( a == 1 )

	a *= 2
	assert( a == 2 )

	a %= 2
	assert( a == 0 )

	a++
	assert( a == 1 )

	a--
	assert( a == 0 )

	a |= 1
	assert( a == 1 )

	a &= 3
	assert( a == 1 )

	a ^= 3
	assert( a == 2 )

	a >>= 1
	assert( a == 1 )

	a <<= 1
	assert( a == 2 )
