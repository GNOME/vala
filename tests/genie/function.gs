global:int = 0

init
	test()
	assert( global == 1 )

def test()
	global += 1
