class Test1
	[CCode (cname="c_test1_field")]
	test1_field: int = 2

	[CCode (cname="c_test1_prop")]
	prop test1_prop: int = 1

	[CCode (cname="c_test1_method")]
	def test1_method ([CCode (cname="c_a")]
					  a: int = 3,

					  [CCode (cname="c_b")]
					  b: int = 4

					  ): int
		return a + b

class Test2
	[CCode (cname="c_test2_field")] test2_field: int = 2
	[CCode (cname="c_test2_prop")] prop test2_prop: int = 1
	[CCode (cname="c_test2_method")] def test2_method ([CCode (cname="c_a")] a: int = 3,
													   [CCode (cname="c_b")] b: int = 4
													   ): int
		return a + b

init
	var test1 = new Test1
	var test2 = new Test2
	print(@"Test1: $(test1.test1_field) $(test1.test1_prop) $(test1.test1_method())")
	print(@"Test2: $(test2.test2_field) $(test2.test2_prop) $(test2.test2_method())")
