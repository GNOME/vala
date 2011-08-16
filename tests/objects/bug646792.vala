public class Wrapper<G> {
	public G item;
	public G *ptr;
}

void main () {
	var item = new Wrapper<Wrapper<string>> ();
	Wrapper<string> inner_item = item.item;
	Wrapper<string> *inner_ptr = item.ptr;
}
