init // comment
/* comment */
	d: int = 0
	var j = 0
//		i = 0
		
		//		i = 0
//		i = 0
	//		i = 0
			//		i = 0
	if j != 0 //this is possible, earlier was "i != 0", which was, of course, impossible
		d = 4 /* comment
		comment */
	else
		/* comment */
		d = 5
		/* comment */
	
	assert j == 0
	assert d == 5

	if_if_slc_indent()


def if_if_slc_indent()
	var hit = false
	if false
		pass
	if false
		pass
			//indented comment
	if true
		hit = true

	assert hit == true
