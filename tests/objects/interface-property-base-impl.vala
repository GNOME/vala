public interface IFoo : Object {
    public abstract int prop { get; set; }
}

public class Foo : Object, IFoo {
    public int prop { get; set; }
}

public class Bar : Foo, IFoo {
}

void main (){
    IFoo bar = new Bar ();
    bar.prop = 42;
    assert (bar.prop == 42);
}
