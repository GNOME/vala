void main () {
    int i = 0;
    string s;

    with (i) {
        s = i.to_string ();
    }

    assert (s == "0");
}
