public class Foo : GLib.Object {
  public string? bar { get; construct; }

  public Foo () {
    GLib.Object (bar: (string?) null);
  }
}

void main () {
}