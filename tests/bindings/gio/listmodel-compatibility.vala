[CCode (no_generic_args = true)]
class NotAListView<G> : Object where G : Object {
	public Type g_type { get; construct; default = typeof (Object); }

	public ListModel<G> model { get; set; }

	public NotAListView.with_type (Type g_type) {
		Object (g_type: g_type);
	}

	construct {
		model = new ListStore<G> (g_type);
	}
}

class Foo : Object, ListModel {
	public ListModel model { get; set; }

	public NotAListView other_thing { get; set; }

	public Type get_item_type () {
		return typeof (Object);
	}

	public Object? get_item (uint pos) {
		return null;
	}

	public uint get_n_items () {
		return 0;
	}
}

void main () {
	ListModel l = (ListModel) new ListStore (typeof (ListModel));
	Object? o = l.get_item (10);

	Foo foo = new Foo ();
	foo.model = l;
	o = foo.model.get_item (0);

	NotAListView n = new NotAListView ();
	o = n.model.get_item (0);
	l = foo;

	n = new NotAListView ();
	n.model = l;
	l = n.model;
}
