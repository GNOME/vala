[Compact]
class Cmpct {
    public int i;
}

void main() {
    var c = new Cmpct();
    with (c) {
        i = 13;
    }

    assert (c.i == 13);
}
