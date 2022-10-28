def m():string
	return "foo"

init
	result:string = @""""""
	assert( result == "" )

	i:int = 42
	result = @"""i=$i 
m=$( m() ) 
$$"""
	assert( result == "i=42 \nm=foo \n$" )

	a:int = 4711
	result = @""""$a"""""
	assert( result == "\"4711\"\"" )
