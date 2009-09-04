
using Gee;


public abstract class Valadoc.Html.InlineElement : Valadoc.Html.Element {
	public override string to_string (uint depth, string path) {
		StringBuilder str = new StringBuilder ("<");
		str.append (this.tag);
		str.append (this.attributes_to_string (path));
		if (this.children.size > 0) {
			str.append_c ('>');

			str.append (this.children_to_string (depth+1, path));

			str.append ("</");
			str.append (this.tag);
			str.append (">");
		}
		else {
			str.append (" />");
		}
		return str.str;
	}
}


public class Valadoc.Html.Span : Valadoc.Html.InlineElement {
	private static string mytag = "span";

	public Span () {
		this.tag = mytag;
	}

	public Span.from_list (Collection<Entry> list) {
		this.tag = mytag;

		foreach (Entry e in list) {
			this.children.add (e);
		}
	}
}


public class Valadoc.Html.HyperLink : Valadoc.Html.InlineElement {
	private static string mytag = "a";
	private Attribute path;

	public HyperLink (string path, Entry desc) {
		this.path = new Attribute ("href", path);
		this.add_attribute (this.path);
		this.children.add (desc);
		this.tag = mytag;
	}

	public HyperLink.from_list (string path, Collection<Entry> descs) {
		this.path = new Attribute ("href", path);
		this.add_attribute (this.path);
		this.tag = mytag;

		foreach (Entry desc in descs) {
			this.children.add (desc);
		}
	}
}


public class Valadoc.Html.Image : Valadoc.Html.InlineElement {
	private static string mytag = "img";

	public Image (string path) {
		this.tag = mytag;
	}
}

public class Valadoc.Html.Italic : Valadoc.Html.InlineElement {
	private static string mytag = "i";

	public Italic () {
		this.tag = mytag;
	}
}

