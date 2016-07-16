[indent=4]
class Test : Object
    delegate DelegateType (a : int)
    data : int = 5
    d : DelegateType

    construct()
        self.d = method

    def method (b:int)
        print "%d %d", b, data

    def run (c:int)
        d(c)

init
    var t = new Test()
    t.run(1)
