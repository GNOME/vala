init
	var a = new Test()
	a.foo = "foo"
	assert( a.foo == "foo" )
	assert( a.bar == "bar" )
	a.manam = "manam"
	assert( a.manam == "manam" )

class Test:Object
	prop foo:string
	prop readonly bar:string
		get
			return "bar"
	prop manam:string
		owned get
		set construct
