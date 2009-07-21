
using Gee;


public abstract class Valadoc.Html.Entry {
	public abstract string to_string (uint depth, string path);
}


public class Valadoc.Html.String : Valadoc.Html.Entry {
	private string str;

	public String (string str) {
		this.str = str;
	}

	public override string to_string (uint depth, string path) {
		return this.str;
	}
}


public abstract class Valadoc.Html.Element : Valadoc.Html.Entry {
	protected ArrayList<Attribute> attributes = new ArrayList<Attribute> ();
	protected ArrayList<Entry> children = new ArrayList<Entry> ();
	protected weak string tag;

	public void add_attribute (Attribute att) {
		this.attributes.add (att);
	}

	public void add_attributes (Collection<Attribute> attributes) {
		foreach (Attribute att in attributes) {
			this.attributes.add (att);
		}
	}

	public void add_child (Entry el) {
		this.children.add (el);
	}

	public void add_childs (Collection<Entry> elements) {
		foreach (Entry el in elements) {
			this.children.add (el);
		}
	}

	protected string children_to_string (uint depth, string path) {
		StringBuilder str = new StringBuilder ();

		foreach (Entry child in this.children) {
			str.append (child.to_string(depth, path));
		}
		return str.str;	
	}

	protected string attributes_to_string (string path) {
		if (this.attributes == null) {
			return "";
		}

		StringBuilder str = new StringBuilder ();

		foreach (Attribute att in this.attributes) {
			str.append (att.to_string(path));
		}
		return str.str;
	}
}


public class Valadoc.Html.Document {
	private Html root;

	public void set_root (Html root) {
		this.root = root;
	}

	public string to_string (string path) {
		if (this.root == null) {
			return "";
		}

		return this.root.to_string (0, path);
	}
}

