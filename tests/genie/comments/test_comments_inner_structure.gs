/* It's failing on newly compiled vala builds (with --pkg=libvala-0.38), but
 * it was passed if I used:"--pkg=libvala-0.34" (installed to system),
 * configured environment variable:
 * XDG_DATA_DIRS="${XDG_DATA_DIRS}:/path_to_root_of_sources/share" valac 'path to this file'
 */

init

	test_fc_slc_1 ()
	test_fc_slc_2 ()
	test_fc_slc_3 ()
	test_fc_slc_4 ()

	test_fc_mlc_1 ()
	test_fc_mlc_2 ()
	test_fc_mlc_3 ()
	test_fc_mlc_4 ()

	test_fc_docc_1 ()
	test_fc_docc_2 ()
	test_fc_docc_3 ()
	test_fc_docc_4 ()


class Comment : Object
	prop line : int
	prop column : int
	prop content : string
	construct(line : int, column : int, content : string)
		_line = line
		_column = column
		_content = content

class Source
	prop content : string
	prop comments : array of Comment

def test_fc_slc_1()
	do_test(new Source() {
		content =
"""[indent=4]
init
    pass
"""
	})

def test_fc_slc_2()
	do_test(new Source() {
		content =
"""//comment1
[indent=4]
init
    pass
""",
		comments = {new Comment(1, 1, "//comment1")}
	})

def test_fc_slc_3()
	do_test(new Source() {
		content =
"""//comment1
//comment2
[indent=4]
init
    pass
""",
		comments = {new Comment(1, 1, "//comment1")}
	})

def test_fc_slc_4()
	do_test(new Source() {
		content =
"""//comment1
//comment2
//comment3
[indent=4]
init
    pass
""",
		comments = {new Comment(1, 1, "//comment1")}
	})


def test_fc_mlc_1()
	do_test(new Source() {
		content =
"""/*comment1*/
[indent=4]
init
    pass
""",
		comments = {new Comment(1, 1, "comment1")}
	})

def test_fc_mlc_2()
	do_test(new Source() {
		content =
"""/*comment1*//*comment2*/
[indent=4]
init
    pass
""",
		comments = {
			new Comment(1, 1, "comment1"),
			new Comment(1, 11, "comment2")
			}
	})

def test_fc_mlc_3()
	do_test(new Source() {
		content =
"""/*comment1*//*comment2*/
/*comment3*/
[indent=4]
init
    pass
""",
		comments = {
			new Comment(1, 1, "comment1"),
			new Comment(1, 11, "comment2")
			}
	})

def test_fc_mlc_4()
	do_test(new Source() {
		content =
"""/*comment1*/
/*comment2*/
/*comment3*/
[indent=4]
init
    pass
""",
		comments = {
			new Comment(1, 1, "comment1")
			}
	})

def test_fc_docc_1()
	do_test(new Source() {
		content =
"""/**comment1*/
[indent=4]
init
    pass
"""
	})

def test_fc_docc_2()
	do_test(new Source() {
		content =
"""/**comment1*//**comment2*/
[indent=4]
init
    pass
"""
	})

def test_fc_docc_3()
	do_test(new Source() {
		content =
"""/**comment1*//**comment2*/
/**comment3*/
[indent=4]
init
    pass
"""
	})

def test_fc_docc_4()
	do_test(new Source() {
		content =
"""/**comment1*/
/**comment2*/
/**comment3*/
[indent=4]
init
    pass
"""
	})

def do_test(source : Source)
	var ctxt = new Vala.CodeContext()
	Vala.CodeContext.push(ctxt)

	var source_file = new Vala.SourceFile(ctxt,
							Vala.SourceFileType.SOURCE,
							"file_comment_test",
							source.content)
	var scanner = new Vala.Genie.Scanner(source_file)
	scanner.indent_spaces = 4
	scanner.parse_file_comments()

	var actual_comments = source_file.get_comments()
	var expected_comments = source.comments

	assert(actual_comments.size is expected_comments.length)

	for var i = 0 to (actual_comments.size - 1)
		var actual_comment = actual_comments[i]
		var expected_comment = expected_comments[i]
		var actual_location = actual_comment.source_reference.begin
		var actual_content = actual_comment.content

		//print("line %02i, col %02i, len %02i: %s",
		//	actual_location.line,
		//	actual_location.column,
		//	actual_content.length,
		//	actual_content)

		assert(actual_content is expected_comment.content)
		assert(actual_location.line is expected_comment.line)
		assert(actual_location.column is expected_comment.column)

