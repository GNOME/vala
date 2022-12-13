void main () {
    {
        var foo = 123;
        var bar = 123;
        assert (foo == bar == 123);
    }
    {
        var foo = 111;
        var bar = 222;
        assert (foo != bar == 222);
    }
    {
        var foo = 111;
        var bar = 111;
        assert (foo == bar != 222);
    }
    {
        var foo = 111;
        var bar = 111;
        assert (0 < foo == bar < 222);
    }
    {
        var a = 111;
        var b = 111;
        var c = 111;
        assert (a == b == c == 111);
    }
    {
        var a = 111;
        var b = 222;
        var c = 333;
        assert (a != b != c != 123);
    }
    {
        var foo = "world";
        var bar = "hello";
        assert (foo > bar == "hello");
    }
    {
        var a = "hello";
        var b = "hello";
        var c = "hello";
        assert ("hello" == a <= b == c == "hello" <= "hello");
    }
    {
        var foo = "h";
        var bar = "h";
        assert (foo == bar < "hello");
    }
    {
        var foo = "hello";
        var bar = "world";
        assert (foo != bar == "world");
    }
    {
        var foo = "world";
        var bar = "world";
        assert (foo == bar != "hello");
    }
    {
        var foo = "world";
        var bar = "world";
        assert ((foo == bar != "hello") == (0 == 0 <= 1)); // true == true
    }
    {
        var foo = "world";
        var bar = "world";
        assert ((foo == bar == "hello") == (1 == 1 <= 0)); // false == false
    }
}
