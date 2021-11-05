init
	var a = new Test()
	assert( a.a == "a" )
	assert( a.b == "b" )
	assert( a.c == "c" )

class Test
	a:string = "a"
	b:class string = "b"
	c:static string = "c"
