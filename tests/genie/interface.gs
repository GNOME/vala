init
	var a = new Test()
	assert( a.test(42) )

interface ITest:Object
	def abstract test( a:int ):bool

class Test:Object implements ITest
	def test( a:int ):bool
		return a == 42
