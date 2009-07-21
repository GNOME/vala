
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

