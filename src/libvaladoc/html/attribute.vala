
using Gee;


public class Valadoc.Html.Attribute {
	private string name;
	private string val;

	public Attribute (string name, string val) {
		this.name = name;
		this.val = val;
	}

	public string to_string (string path) {
		return " %s=\"%s\"".printf (this.name, this.val);
	}
}

