delegate TestFunction():bool

init
	assert( test()() == true )

def test():TestFunction
	return def()
		return true
