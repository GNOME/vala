int f (delegate(int) => int d = (a) => 2*a) {
    return d (7);
}

void main () {
    assert (f (a => a) == 7);
    assert (f () == 14);
}
