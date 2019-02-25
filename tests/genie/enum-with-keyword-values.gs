init
	var a = Test.ONE
	var b = Test.ABSTRACT
	c:Test = Test.DEF
	d:Test = Test.FOUR

	assert( a == Test.ONE )
	assert( b == Test.ABSTRACT )
	assert( c == Test.DEF )
	assert( d == Test.FOUR )

enum Test
	ONE
	ABSTRACT
	DEF
	FOUR
