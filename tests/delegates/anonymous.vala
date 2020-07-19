void main () {
    f ((a, b) => {
        return a + b;
    });
}

void f (delegate(int, int) => int abc) {
    assert (abc (1, 2) == 3);
}
