/* --pkg="gee=0.8" needed
Old syntax: "for var i = 1 to 10", "for var i = 1 ... 10"
New syntax: "for i in 1 to 10", "for i in 1...10"
*/

init
	
	old_syntax_int_up ()
	old_syntax_int_down ()
	old_syntax_var_up ()
	old_syntax_var_down ()
	old_syntax_int_up_ellipsis ()
	old_syntax_int_down_ellipsis ()
	old_syntax_var_up_ellipsis ()
	old_syntax_var_down_ellipsis ()
	old_syntax_int_up_zero_times ()
	old_syntax_int_down_zero_times ()
	old_syntax_var_up_zero_times ()
	old_syntax_var_down_zero_times ()
	
	new_syntax_int_up ()
	new_syntax_int_down ()
	new_syntax_var_up ()
	new_syntax_var_down ()
	new_syntax_int_up_ellipsis ()
	new_syntax_int_down_ellipsis ()
	new_syntax_var_up_ellipsis ()
	new_syntax_var_down_ellipsis ()
	new_syntax_int_up_zero_times ()
	new_syntax_int_down_zero_times ()
	new_syntax_var_up_zero_times ()
	new_syntax_var_down_zero_times ()
	
	new_syntax_up ()
	new_syntax_down ()
	new_syntax_up_ellipsis ()
	new_syntax_down_ellipsis ()
	new_syntax_up_zero_times ()
	new_syntax_down_zero_times ()




def old_syntax_int_up ()
	
	var array_1 = new list of int
	
	for a: int = 4 to 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def old_syntax_int_down ()
	
	var array_1 = new list of int
	
	for a: int = 8 downto 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def old_syntax_var_up ()
	
	var array_1 = new list of int
	
	for var a = 4 to 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def old_syntax_var_down ()
	
	var array_1 = new list of int
	
	for var a = 8 downto 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def old_syntax_int_up_ellipsis ()
	
	var array_1 = new list of int
	
	for a: int = 4 ... 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def old_syntax_int_down_ellipsis ()
	
	var array_1 = new list of int
	
	for a: int = 8 ... 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def old_syntax_var_up_ellipsis ()
	
	var array_1 = new list of int
	
	for var a = 4 ... 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def old_syntax_var_down_ellipsis ()
	
	var array_1 = new list of int
	
	for var a = 8 ... 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def old_syntax_int_up_zero_times ()
	
	var array_1 = new list of int
	
	for a: int = 8 to 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def old_syntax_int_down_zero_times ()
	
	var array_1 = new list of int
	
	for a: int = 4 downto 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def old_syntax_var_up_zero_times ()
	
	var array_1 = new list of int
	
	for var a = 8 to 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def old_syntax_var_down_zero_times ()
	
	var array_1 = new list of int
	
	for var a = 4 downto 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0




def new_syntax_int_up ()
	
	var array_1 = new list of int
	
	for a: int in 4 to 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def new_syntax_int_down ()
	
	var array_1 = new list of int
	
	for a: int in 8 downto 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def new_syntax_var_up ()
	
	var array_1 = new list of int
	
	for var a in 4 to 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def new_syntax_var_down ()
	
	var array_1 = new list of int
	
	for var a in 8 downto 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def new_syntax_int_up_ellipsis ()
	
	var array_1 = new list of int
	
	for a: int in 4 ... 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def new_syntax_int_down_ellipsis ()
	
	var array_1 = new list of int
	
	for a: int in 8 ... 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def new_syntax_var_up_ellipsis ()
	
	var array_1 = new list of int
	
	for var a in 4 ... 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def new_syntax_var_down_ellipsis ()
	
	var array_1 = new list of int
	
	for var a in 8 ... 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def new_syntax_int_up_zero_times ()
	
	var array_1 = new list of int
	
	for a: int in 8 to 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def new_syntax_int_down_zero_times ()
	
	var array_1 = new list of int
	
	for a: int in 4 downto 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def new_syntax_var_up_zero_times ()
	
	var array_1 = new list of int
	
	for var a in 8 to 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def new_syntax_var_down_zero_times ()
	
	var array_1 = new list of int
	
	for var a in 4 downto 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0




def new_syntax_up ()
	
	var array_1 = new list of int
	
	var c = 18 - 14
	
	for a in c to 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def new_syntax_down ()
	
	var array_1 = new list of int
	
	c: int = 8
	
	for a in c downto 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def new_syntax_up_ellipsis ()
	
	var array_1 = new list of int
	
	var c = 18 - 14
	
	for a in c ... 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 4
	assert array_1 [1] == 5
	assert array_1 [2] == 6
	assert array_1 [3] == 7
	assert array_1 [4] == 8


def new_syntax_down_ellipsis ()
	
	var array_1 = new list of int
	
	for a in 8 ... 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 5
	
	assert array_1 [0] == 8
	assert array_1 [1] == 7
	assert array_1 [2] == 6
	assert array_1 [3] == 5
	assert array_1 [4] == 4


def new_syntax_up_zero_times ()
	
	var array_1 = new list of int
	
	for a in 4 downto 8
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0


def new_syntax_down_zero_times ()
	
	var array_1 = new list of int
	
	for a in 8 to 4
		array_1.add (a)
	
	len_1: int = array_1.size
	assert len_1 == 0
