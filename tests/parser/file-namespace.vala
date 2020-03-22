namespace Foo.Bar;

class Maman {
    private static int pi = 4;

    public static void run () {
        assert (typeof (Bar.Maman).name () == "FooBarMaman");
        assert (Maman.pi == 4);
    }
}

void main () {
    Maman.run ();
}
