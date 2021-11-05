init
	var a = new Test()
	a.foo.connect( test )
	assert( a.foo(23) )
	a.foo.disconnect( test )

def test( a:int ):bool
	return a == 23

class Test
	event foo( a:int ):bool
