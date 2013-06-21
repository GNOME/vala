public abstract class ClassA : Object {
    public abstract int flags { get; }
}

public class ClassB : ClassA {
    public override int flags { get { return 1; } }
}

public class ClassC : ClassB {
    public void foo() {
    }
}

public class ClassD : ClassC {
    public override int flags {
        get {
            var old_flags = base.flags;

            return old_flags | 2;
        }
    }
}

void main () {
    var d = new ClassD ();
	assert (d.flags == 3);
}
