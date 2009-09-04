
using Gee;


public abstract class Valadoc.Html.BlockElement : Valadoc.Html.Element {
	public override string to_string (uint depth, string path) {
		string depthstr = string.nfill (depth, '\t');
		StringBuilder str = new StringBuilder (depthstr);
		str.append_c ('<');
		str.append (this.tag);
		str.append (this.attributes_to_string (path));
		if (this.children.size > 0) {
			str.append (">\n");

			str.append (this.children_to_string (depth+1, path));

			str.append_c ('\n');
			str.append (depthstr);
			str.append ("</");
			str.append (this.tag);
			str.append (">\n");
		}
		else {
			str.append (" />\n");		
		}
		return str.str;
	}
}


public class Valadoc.Html.Html : Valadoc.Html.BlockElement {
	private static string mytag = "html";

	public Html () {
		this.tag = mytag;
	}
}


public class Valadoc.Html.Head : Valadoc.Html.BlockElement {
	private static string mytag = "head";

	public Head () {
		this.tag = mytag;
	}
}


public class Valadoc.Html.Body : Valadoc.Html.BlockElement {
	private static string mytag = "body";

	public Body () {
		this.tag = mytag;
	}
}


public class Valadoc.Html.Div : Valadoc.Html.BlockElement {
	private static string mytag = "div";

	public Div () {
		this.tag = mytag;
	}
}

public class Valadoc.Html.Script : Valadoc.Html.BlockElement {
	private static string mytag = "script";
	private Attribute lang;
	private Attribute type;
	private Attribute src;

	public Script (string lang, string src, string type) {
		this.lang = new Attribute ("type", lang);
		this.type = new Attribute ("rel", type);
		this.src = new Attribute ("href", src);

		this.add_attribute (this.lang);
		this.add_attribute (this.type);
		this.add_attribute (this.src);

		this.tag = mytag;
	}
}

public class Valadoc.Html.Headline : Valadoc.Html.BlockElement {
	private static string mytag;

	public Headline (int lvl) {
		mytag = "h%d".printf (lvl);
		this.tag = mytag;
	}
}

public class Valadoc.Html.Title : Valadoc.Html.BlockElement {
	private static string mytag = "title";
	private String title;

	public Title (string title) {
		this.tag = mytag;
		this.title = new String (title);
		this.add_child (this.title);
	}
}

public class Valadoc.Html.Link : Valadoc.Html.BlockElement {
	private static string mytag = "link";
	private Attribute lang;
	private Attribute type;
	private Attribute src;

	public Link (string lang, string src, string type) {
		this.lang = new Attribute ("type", lang);
		this.type = new Attribute ("rel", type);
		this.src = new Attribute ("href", src);

		this.add_attribute (this.lang);
		this.add_attribute (this.type);
		this.add_attribute (this.src);

		this.tag = mytag;
	}
}

