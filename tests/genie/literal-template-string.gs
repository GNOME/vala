def m():string
	return "foo"

init
	result:string = @""
	assert( result == "" )

	i:int = 42
	result = @"i=$i m=$( m() ) $$"
	assert( result == "i=42 m=foo $" )
