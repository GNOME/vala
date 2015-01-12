class Xyzzy : Object {
    public bool b { get; set; }
}

Xyzzy? xyzzy = null;

private void on_b() {
}

async void go_async() throws Error {
    xyzzy.notify["b"].disconnect(on_b);
}

void main () {
}
