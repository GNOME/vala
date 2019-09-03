init
	var a = Test()
	assert( a.empty == "" )

struct Test
	empty:string

	construct()
		self.empty = ""
