init
	var a = new TestClass()
	var b = TestStruct()
	assert( a.empty == b.empty )

class TestClass
	empty:string = ""

struct TestStruct
	empty:string

	construct()
		empty = ""
