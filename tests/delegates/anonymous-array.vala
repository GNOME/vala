void main () {
    f ((a, b) => {
        int r = 0;
        for (int i = 0; i < a.length; i++) {
            r += a[i] * b[i];
        }
        return r;
    });
}

void f (delegate(int[], int[]) => int abc) {
    int i[] = {1, 2, 3};
    int j[] = {7, 8, 9};
    assert (abc (i, j) == 50);
}
