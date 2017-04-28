/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright 2016 Chris Daley <chebizarro@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * Authors:
 * 	Chris Daley <chebizarro@gmail.com>
 */

public errordomain Valadate.XmlFileError {
	ERROR
}

public class Valadate.XmlSearchResults {
	
	private Xml.XPath.Object* result;

	public int size {
		get {
			if(result == null || result->type != Xml.XPath.ObjectType.NODESET || result->nodesetval == null)
				return 0;
			return result->nodesetval->length();
		}
	}

	public void* get(int i)
		requires(size > 0)
		requires(i < size)
		requires(i >= 0)
	{
		return result->nodesetval->item (i);
	}
	
	
	internal XmlSearchResults(Xml.XPath.Object* result) {
		this.result = result;
	}

	~XmlSearchResults() {
		if(result != null) delete result;
	}

}

public class Valadate.XmlFile {
	
	private Xml.Doc* document;
	private Xml.XPath.Context context;
	private bool owns_doc = false;
	
	public XmlFile(File path) throws Error {
		this.from_doc(Xml.Parser.parse_file(path.get_path()));
		owns_doc = true;
	}

	internal XmlFile.from_doc(Xml.Doc* xmldoc) throws Error {
		document = xmldoc;
		owns_doc = true;

		if (document == null)
			throw new XmlFileError.ERROR(
				"There was an error parsing the Xml.Doc");

		set_context();
	}

	public XmlFile.from_string(string xml) throws Error {
		document = Xml.Parser.read_memory(xml, xml.length, null, null,
			Xml.ParserOption.RECOVER | Xml.ParserOption.NOERROR |
			Xml.ParserOption.NOWARNING | Xml.ParserOption.NOBLANKS);
		owns_doc = true;

		if (document == null)
			throw new XmlFileError.ERROR(
				"There was an error parsing the string %s", xml);
		set_context();
	}

	private void set_context() {
		context = new Xml.XPath.Context (document);
	}

	~XmlFile() {
		if (owns_doc)
			delete document;
	}

	public void register_ns(string prefix, string ns) {
		context.register_ns(prefix, ns);
	}

	public XmlSearchResults eval(string expression) {
		return new XmlSearchResults(context.eval_expression (expression));
	}
	
}
