/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

using Valadoc;
using GLib;



public static class CssFile {
	public const string css = "body {\n	font-family: sans-serif;\n	margin-top: 2.8em;\n}\n\nh1, h2, h3, h4 {\n	color: #005a9c;\n}\n\nh5 {\n	color: #005a9c;\n	margin: 0;\n}\n\na {\n	color: #005a9c;\n	text-decoration: none;\n}\n\n.toc {\n	font-weight: bold;\n	font-size: larger;\n}\n\n.toc li {\n	list-style-type: none;\n}\n\n.toc li li {\n	font-size: smaller;\n}\n\nh3 a {\n	position: relative;\n	top: -2.8em;\n}\n\n.header {\n	background-color: #005a9c;\n	font-weight: bold;\n	padding: .35em;\n	position: fixed;\n	left: 0;\n	top: 0;\n	width: 100%;\n	height: 1.4em;\n}\n\n.header a {\n	color: white;\n}\n\ndiv.note {\n	border: 3px solid #005a9c;\n	padding: 1em;\n	margin: 0 2em 1em 2em;\n}\n\ndiv.note p, div.note h4 {\n	margin: 0;\n}\n\npre {\n	background-color: #eee;\n	border: 1px solid black;\n	padding: .5em 1em;\n	margin: 0 2em 1em 2em;\n}\n\nblockquote {\n	font-style: italic;\n	white-space: pre;\n}\n\nhr {\n	width: 95%;\n	color: #005a9c;\n	background-color: #005a9c;\n}\n\np.foother {\n	text-align: center;\n	color: #005a9c;\n	margin-top: 1px;\n	margin-bottom: 1px;\n}";

	public static void create ( string path ) {
		var file = FileStream.open ( path, "w+" );
		file.puts ( css );
	}
}



public class File : Object {
	protected FileStream file;
	protected int level = 0;

	public string path {
		construct set;
		get;
	}

	public void start_file ( string title, string parent, string to_root ) {
		string file_header = "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n\t<head>\n\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n\t\t<title>%s</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"%sdefault.css\" />\n\t</head>\n\t<body>\n\t\t<div class=\"header\">\n\t\t\t<a href=\"%s\">%s</a>\n\t\t</div>";

		this.file = FileStream.open ( this.path, "w+" );
		this.file.printf ( file_header, title, to_root, parent, title );
	}

	public void end_file ( ) {
		this.file.puts ( "\n\t\t<hr><p class=\"foother\">Created by Valadoc</p>\n\t</body>\n</html>" );
	}
}



public class DocFile : File, LinkHelper {
	private LangletIndex langlet;
	private int headlinelvl = 1;

	public void initialisation ( ) {
		this.langlet = new LangletIndex( this.settings );
	}

	public DocFile ( string path, Settings settings ) {
		this.path = path;
		this.settings = settings;
	}

	public Settings settings {
		construct set;
		get;
	}

	public void index_space ( int[] sizes, int pos ) {
		int elements = 0;

		if ( pos + 1 == sizes.length )
			return ;

		if ( sizes[pos] == 0 )
			return ;

		for ( int i = pos+1; i < sizes.length ; i++ )
			elements += sizes[i];

		if ( elements != 0 )
			this.file.puts ( "\n\n" );
	}

	public void index_start_synopsis ( ) {
		this.headlinelvl++;

		this.langlet.with_link = true;
		this.file.puts ( "<h%d>Synopsis</h%d>\n".printf( this.headlinelvl, this.headlinelvl) );
		this.file.puts ( "<pre>\n" );
	}

	public void index_end_synopsis ( ) {
		this.langlet.with_link = false;
		this.file.puts ( "</pre><br>" );
		this.headlinelvl--;
	}

	public void index_add_method ( Valadoc.Method m, Valadoc.MethodHandler parent ) {
		m.write ( this.langlet, this.file, parent );
		this.file.puts ( "\n" );
	}

	public void index_add_delegate ( Valadoc.Delegate del ) {
		del.write ( this.langlet, this.file );
		this.file.puts ( "\n" );
	}

	public void index_add_field ( Valadoc.Field f, Valadoc.FieldHandler parent ) {
		f.write ( this.langlet, this.file, parent );
		this.file.puts ( "\n" );
	}

	public void index_add_property ( Valadoc.Property prop ) {
		prop.write ( this.langlet, this.file );
		this.file.puts ( "\n" );
	}

	public void index_add_signal ( Valadoc.Signal sig ) {
		sig.write ( this.langlet, this.file );
		this.file.puts ( "\n" );
	}

	public void index_start_error_domain ( Valadoc.ErrorDomain errdom ) {
		errdom.write ( this.langlet, this.file );
		this.file.puts ( " {\n" );
	}

	public void index_end_error_domain ( ) {
		this.file.puts ( "}\n" );
	}

	public void index_start_enum ( Valadoc.Enum en ) {
		en.write ( this.langlet, this.file );
		this.file.puts ( " {\n" );
	}

	public void index_end_enum ( ) {
		this.file.puts ( "}\n" );
	}

	public void index_start_interface ( Valadoc.Interface iface ) {
		iface.write ( this.langlet, this.file );
		this.file.puts ( " {\n" );
	}

	public void index_end_interface ( ) {
		this.file.puts ( "}\n" );
	}

	public void index_add_error_code ( Valadoc.ErrorCode errcode ) {
		errcode.write ( this.langlet, this.file );
		this.file.puts ( "\n" );
	}

	public void index_add_enum_value ( Valadoc.EnumValue enval ) {
		enval.write ( this.langlet, this.file );
		this.file.puts ( "\n" );
	}

	public void index_start_struct ( Valadoc.Struct stru ) {
		stru.write ( this.langlet, this.file );
		this.file.puts ( " {\n" );
	}

	public void index_end_struct ( Valadoc.Struct stru ) {
		// TODO: Teach langlet to write a \t -> '    '
		this.file.puts ( string.nfill( stru.bracket_level*4,' ' ) );
		this.file.puts ( "}\n" );
	}

	public void index_start_class ( Valadoc.Class cl ) {
		cl.write ( this.langlet, this.file );
		this.file.puts ( " {\n" );
	}

	public void index_end_class ( Valadoc.Class cl ) {
		// TODO: Teach langlet to write a \t -> '    '
		this.file.puts ( string.nfill( cl.bracket_level*4,' ' ) );
		this.file.puts ( "}\n" );
	}

	public void doc_delegate_block_start (  ) {
		this.headlinelvl++;
		this.file.puts ( "<h%d>Delegate Details</h%d>\n".printf ( this.headlinelvl, this.headlinelvl ) );
	}

	public void doc_delegate_block_end (  ) {
		this.headlinelvl--;
	}


	public void add_description ( DataType type ) {
		type.write_comment ( this.file );
	}

	// replace with add_description + headline
	public void start_description ( DataType type ) {
		this.headlinelvl++;
		this.file.printf( "\t\t<h%d>%s</h%d>\n", this.headlinelvl, "Description", this.headlinelvl );
		type.write_comment ( this.file );
	}

	public void end_description ( ) {
		this.headlinelvl--;
	}

	public void start_type_detail ( string typename ) {
		this.headlinelvl++;
		this.file.printf( "\t\t<h%d>%s %s</h%d>\n", this.headlinelvl, typename, "Description", this.headlinelvl );
	}

	public void end_type_detail ( ) {
		this.headlinelvl--;
	}

	public void start_detail ( ) {
		this.headlinelvl++;
		this.file.printf ( "\t\t<h%d>Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail ( ) {
		this.headlinelvl--;
	}

	public void start_detail_method ( ) {
		this.headlinelvl++;
		this.file.printf ( "\t\t<h%d>Method Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_method ( ) {
		this.headlinelvl--;
	}

	public void start_detail_construction_method ( ) {
		this.headlinelvl++;
		this.file.printf ( "\t\t<h%d>Constructor Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_construction_method ( ) {
		this.headlinelvl--;
	}

	public void add_detail_method ( Valadoc.Method m, Valadoc.MethodHandler parent ) {
		this.file.printf ( "\t\t<h%d>%s ()</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, m.name,
												this.headlinelvl+1, this.get_mark_name ( m ) );

		this.file.puts ( "\t\t<pre>\n" );
		m.write ( this.langlet, this.file, parent );
		this.file.puts ( "\t\t</pre>\n" );

		m.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}

	public void start_detail_field ( ) {
		this.headlinelvl++;
		this.file.printf ( "\t\t<h%d>Field Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_field ( ) {
		this.headlinelvl--;
	}

	public void add_detail_field ( Valadoc.Field f, Valadoc.FieldHandler parent ) {
		this.file.printf ( "\t\t<h%d>%s</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, f.name,
											 this.headlinelvl+1, this.get_mark_name ( f ) );

		this.file.puts ( "\t\t<pre>\n" );
		f.write ( this.langlet, this.file, parent );
		this.file.puts ( "\t\t</pre>\n" );

		f.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}

	public void start_detail_property ( ) {
		this.headlinelvl++;
		this.file.printf ( "\t\t<h%d>Property Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_property ( ) {
		this.headlinelvl--;
	}

	public void add_detail_property ( Valadoc.Property prop ) {
		this.file.printf ( "\t\t<h%d>%s</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, prop.name,
											this.headlinelvl+1, this.get_mark_name ( prop ) );

		this.file.puts ( "\t\t<pre>\n" );
		prop.write ( this.langlet, this.file );
		this.file.puts ( "\t\t</pre>\n" );

		prop.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}

	public void start_detail_signal ( ) {
		this.headlinelvl++;
		this.file.printf( "\t\t<h%d>Signal Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_signal ( ) {
		this.headlinelvl--;
	}

	public void add_detail_signal ( Valadoc.Signal sig ) {
		this.file.printf ( "\t\t<h%d>%s</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, sig.name,
											this.headlinelvl+1, this.get_mark_name ( sig ) );

		this.file.puts ( "\t\t<pre>\n" );
		sig.write ( this.langlet, this.file );
		this.file.puts ( "\t\t</pre>\n" );

		sig.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}


	public void start_detail_delegate ( ) {
		this.headlinelvl++;
		this.file.printf( "\t\t<h%d>Delegate Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_delegate ( ) {
		this.headlinelvl--;
	}

	public void add_detail_delegate ( Valadoc.Delegate del ) {
		this.file.printf ( "\t\t<h%d>%s ()</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, del.name,
											this.headlinelvl+1, this.get_mark_name ( del ) );

		this.file.puts ( "\t\t<pre>\n" );
		del.write ( this.langlet, this.file );
		this.file.puts ( "\t\t</pre>\n" );

		del.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}

	public void start_detail_error_code ( ) {
		this.headlinelvl++;
		this.file.printf( "\t\t<h%d>Error Code Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_error_code ( ) {
		this.headlinelvl--;
	}

	public void start_detail_enum_value ( ) {
		this.headlinelvl++;
		this.file.printf( "\t\t<h%d>Enum Value Details</h%d>\n", this.headlinelvl, this.headlinelvl );
	}

	public void end_detail_enum_value ( ) {
		this.headlinelvl--;
	}

	public void add_detail_error_code ( Valadoc.ErrorCode errcode ) {
		this.file.printf ( "\t\t<h%d>%s</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, errcode.name,
												this.headlinelvl+1, this.get_mark_name( errcode ) );

		this.file.puts ( "\t\t<pre>\n" );
		errcode.write ( this.langlet, this.file );
		this.file.puts ( "\t\t</pre>\n" );

		errcode.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}

	public void add_detail_enum_value ( Valadoc.EnumValue enval ) {
		this.file.printf ( "\t\t<h%d>%s</h%d> <a name=\"%s\"></a>\n", this.headlinelvl+1, enval.name,
												this.headlinelvl+1, this.get_mark_name( enval ) );

		this.file.puts ( "\t\t<pre>\n" );
		enval.write ( this.langlet, this.file );
		this.file.puts ( "\t\t</pre>\n" );

		enval.write_comment ( this.file );
		this.file.puts ( "\n\t\t<hr>\n" );
	}
}



public class IndexFile : File {
	public IndexFile ( string path ) {
		this.path = path;
	}

	public void open_point ( string name, string link ) {
		string space = string.nfill ( this.level, '\t' );
		this.level++;

		if ( this.level == 1 ) {
			file.puts ( space );
			file.puts( "<ul class=\"toc\">\n" );
		}

		file.puts ( space );
		file.printf( "\t\t<li><a href=\"%s\">%s</a>\n", link, name );

		file.puts ( space );
		file.puts ( "\t\t\t" );
		file.puts( "<ul>\n" );
	}

	public void add_point ( string name, string link ) {
		file.puts ( string.nfill ( this.level, '\t' ) );
		file.printf( "\t\t\t<li><a href=\"%s\">%s</a></li>\n", link, name );
	}

	public void close_point ( ) {
		this.level--;
		string space = string.nfill ( this.level, '\t' );

		file.puts ( space );
		file.puts( "\t\t\t</ul>\n" );

		file.puts ( space );
		file.puts( "\t\t</li>\n" );

		if ( this.level == 0 ) {
			file.puts ( space );
			file.puts( "</ul>\n" );
		}
	}
}


// Move to GlobalIndexFile
private class Element : Object {
	public Element ( string name, string link ) {
		this.name = name;
		this.link = link;
	}

	public string link {
		construct set;
		get;
	}

	public string name {
		construct set;
		get;
	}
}


// Move to GlobalIndexFile
private class Headline< T > : Object {
	private Gee.ArrayList< T > elements = new Gee.ArrayList<T> ();

	public Headline ( string name, string link ) {
		this.name = name;
		this.link = link;
	}

	public Gee.Collection<T> get_elements ( ) {
		return this.elements;
	}

	public void add ( T element ) {
		this.elements.add ( element );
	}

	public string link {
		construct set;
		get;
	}

	public string name {
		construct set;
		get;
	}
}

// TODO: Store the objects instead of strings
// TODO: Create a common index-creator class for doclets
public class GlobalIndexFile : Object {
	private Gee.HashMap< string, Gee.ArrayList<Headline> > tree
		= new Gee.HashMap< string, Gee.ArrayList<Headline> > ( GLib.str_hash, GLib.str_equal );

	private Gee.ArrayList<Element> vapi_files = new Gee.ArrayList<Element> ( );


	public string path {
		construct set;
		get;
	}

	public GlobalIndexFile ( string path ) {
		this.path = path;
	}

	// Workarround for the destructor-issue
	public void @delete ( ) {
		this.write ();
	}

	private string# ns_part_path ( string nsname, string partname ) {
		string str2;
		try {
			string str = new Regex ( Regex.escape_string (" ")).replace_literal ( partname, -1, 0, "_" );
			str2 = new Regex ( Regex.escape_string (":")).replace_literal ( partname, -1, 0, "" );
		}
		catch ( RegexError err ) {
			return null;
		}
		return "ns." + nsname + "." + str2 + ".html";
	}

	// cleanup var-names ..
	private void write ( ) {
		IndexFile main = new IndexFile ( this.path + "index.html" );
		main.start_file ( "Reference Manual", "", "" );

		// <Namespaces>:
		foreach ( string key in this.tree.get_keys() ) {
			string nspath = "ns." + key + ".html";
			IndexFile ns = new IndexFile ( this.path + nspath );
			ns.start_file ( key, "", "" );
			ns.open_point ( key, nspath );

			Gee.ArrayList< Headline<Headline> > nspaces = this.tree.get ( key );
			main.open_point ( key, nspath );

			foreach ( Headline<Element> nspace in nspaces ) {
				var headlines = nspace.get_elements ();
				string nspath = this.ns_part_path ( key, nspace.name );

				IndexFile partindex = new IndexFile ( this.path + nspath );
				partindex.start_file ( key, "", "" );

				partindex.open_point ( nspace.name, nspace.link );
				main.open_point ( nspace.name, nspace.link );
				ns.open_point ( nspace.name, nspace.link );

				foreach ( Element* type in headlines ) {
					main.add_point ( type->name, type->link );
					ns.add_point ( type->name, type->link );
					partindex.add_point ( type->name, type->link );
				}

				partindex.close_point ( );
				partindex.end_file ( );
				main.close_point ( );
				ns.close_point ( );
			}
			main.close_point ( );
			ns.close_point ( );
			ns.end_file ( );
		}		// </Namespaces>:

		// vapis:
		if ( this.vapi_files.size != 0 ) {
			main.open_point ( "vapi-files:", "" );
			foreach ( Element file in this.vapi_files ) {
				var str2 = Path.get_basename ( file.name );
				main.add_point ( str2, file.link );
			}
			main.close_point ( );
		}
		main.end_file ( );
	}

	public void add_file ( string file, string link ) {
		if ( file.has_suffix( ".vapi" ) ) {
			var tmp = new Element ( file, link );
			this.vapi_files.add ( tmp );
		}
	}

	public void add_namespace ( string file, string name, string link ) {
		if ( file.has_suffix( ".vapi" ) )
			return ;

		if ( name == null )
			name = "Global Namespace";

		Gee.ArrayList< Headline<Headline> > headlines = this.tree.get ( name );
		if ( headlines == null ) {
			headlines = new Gee.ArrayList< Headline<Headline> > ();
			this.tree.set ( name, headlines );
		}
	}

	private void add_type ( string title, string file, string nspace, string name, string link ) {
		if ( file.has_suffix( ".vapi" ) )
			return ;

		if ( nspace == null )
			nspace = "Global Namespace";

		// FIXME: Bug: will free the subtime at the end of the method-body without pointer
		// FIXME: Mem-Leak! I don't free the garbage

		Gee.ArrayList< Headline<Headline> > headlines = this.tree.get ( nspace );
		Headline<Element*> element = null;

		foreach ( Headline<Element*> element2 in headlines ) {
			element = element2;
			if ( element.name == title )
				break;

			element = null;
		}

		if ( element == null ) {
			string nspath = this.ns_part_path ( nspace, title );
			element = new Headline<Element*> ( title, nspath );
			headlines.add ( element );
		}

		Element* tmp = new Element ( name, link );
		element.add ( tmp );
	}

	public void add_delegate ( string file, string nspace, string name, string link ) {
		this.add_type ( "Delegate:", file, nspace, name, link );
	}

	public void add_enum ( string file, string nspace, string name, string link ) {
		this.add_type ( "Enums:", file, nspace, name, link );
	}

	public void add_error_domain ( string file, string nspace, string name, string link ) {
		this.add_type ( "Errordomains:", file, nspace, name, link );
	}

	public void add_interface ( string file, string nspace, string name, string link ) {
		this.add_type ( "Interfaces:", file, nspace, name, link );
	}

	public void add_class ( string file, string nspace, string name, string link ) {
		this.add_type ( "Classes:", file, nspace, name, link );
	}

	public void add_struct ( string file, string nspace, string name, string link ) {
		this.add_type ( "Structs:", file, nspace, name, link );
	}

	public void add_global_method ( string file, string nspace, string name, string link ) {
		this.add_type ( "Functions:", file, nspace, name, link );
	}

	public void add_global_field ( string file, string nspace, string name, string link ) {
		this.add_type ( "Global Fields:", file, nspace, name, link );
	}
}


public class Valadoc.Doclet : Object, LinkHelper {
	private GlobalIndexFile ns_view_index;

	/**
	 * Index of all global fieds in current namespace.
	 */
	private IndexFile global_var_index;
	/**
	 * Index of all global functions in current namespace.
	 */
	private IndexFile function_index;
	/**
	 * Index of all interfaces in current namespace.
	 */
	private IndexFile iface_index;
	/**
	 * Index of all functions, fields, enums, etc. in current namespace.
	 */
	private IndexFile main_index;
	/**
	 * Index of all structs in current namespace.
	 */
	private IndexFile stru_index;
	/**
	 * Index of all delegates in current namespace.
	 */
	private IndexFile del_index;
	/**
	 * Index of all classes in current namespace.
	 */
	private IndexFile cl_index;
	/**
	 * Index of all enums in current namespace.
	 */
	private IndexFile en_index;
	/**
	 * Index of all errordomains in current namespace.
	 */
	private IndexFile er_index;
	/**
	 * Index of all interfaces in current namespace.
	 */
	private IndexFile ns_index;

	/**
	 * Documentation of the current root class in { @link ns_name }.
	 *
	 *	@see root_class
	 */
	private DocFile type_doc;
	/**
	 * Documentation of all global fields in { @link ns_name }.
	 */
	private DocFile glob_doc;
	/**
	 * Documentation of all global functions in { @link ns_name }.
	 */
	private DocFile func_doc;
	/**
	 * Documentation of all delegates in { @link ns_name }.
	 */
	private DocFile del_doc;

	/**
	 * The name of the top class of nested types.
	 */
	private string root_class;
	/**
	 * The name of the current source-file.
	 */
	private string file_name;
	/**
	 * Name of the current namespace.
	 */
	private string ns_name;
	/**
	 * The path to the documentation for the current namespace.
	 */
	private string path;
	/**
	 * the title of the current source-file.
	 */
	private string pkg;


	public Doclet ( Settings settings, Valadoc.ErrorReporter err ) {
		this.settings = settings;
		this.err = err;
	}

	public virtual void initialisation (  ) {
		var rt = DirUtils.create ( this.settings.path, 0777 );
		CssFile.create ( this.settings.path + "default.css" );

		this.ns_view_index = new GlobalIndexFile ( this.settings.path );
	}

	public Valadoc.ErrorReporter err {
		construct set;
		protected get;
	}

	public Settings settings {
		construct set;
		protected get;
	}

	private void global_field_visitor ( Valadoc.Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_fields.html";
		string title = "Global Fields:";

		this.global_var_index = new IndexFile ( path );
		this.global_var_index.start_file ( this.pkg, "", "../../" );
		this.global_var_index.open_point ( title, "globals.html" );

		this.main_index.open_point ( title, this.ns_name +  "/index_fields.html" );
		this.ns_index.open_point ( title, "index_fields.html" );

		this.glob_doc = new DocFile ( this.settings.path + this.file_name + "/" + this.ns_name + "/globals.html",
																	this.settings );

		this.glob_doc.initialisation ( );
		this.glob_doc.start_file ( this.pkg, "", "../../" );
		this.glob_doc.index_start_synopsis ( );

		foreach ( Field f in ns.get_field_list() )
			this.glob_doc.index_add_field ( f, null );

		this.glob_doc.index_end_synopsis ( );
		this.glob_doc.start_detail ( );

		ns.visit_fields ( this );

		this.glob_doc.end_detail ( );
		this.global_var_index.close_point ( );
		this.global_var_index.end_file ( );
		this.global_var_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );

		this.glob_doc.end_file ( );
		this.glob_doc = null;
		this.path = null;
	}

	private void globa_method_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_functions.html";
		string title = "Functions:";

		this.function_index = new IndexFile ( path );
		this.function_index.start_file ( this.pkg, "", "../../" );
		this.function_index.open_point ( title, "functions.html" );

		this.main_index.open_point ( title, this.ns_name + "/index_functions.html" );
		this.ns_index.open_point ( title, "index_functions.html" );

		this.func_doc = new DocFile ( this.settings.path + this.file_name + "/" + this.ns_name + "/functions.html",
																	this.settings );

		this.func_doc.initialisation ( );
		this.func_doc.start_file ( this.pkg, "", "../../" );
		this.func_doc.index_start_synopsis ( );

		foreach ( Method m in ns.get_method_list() )
			this.func_doc.index_add_method ( m, null );

		this.func_doc.index_end_synopsis ( );
		this.func_doc.start_detail ( );


		ns.visit_methods ( this );


		this.func_doc.end_detail ( );

		this.function_index.close_point ( );
		this.function_index.end_file ( );
		this.function_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );

		this.func_doc.end_file ( );
		this.func_doc = null;
		this.path = null;
	}

	private void property_visitor ( PropertyHandler ph ) {
		this.type_doc.start_detail_property ( );
		ph.visit_properties ( this );
		this.type_doc.end_detail_property ( );
	}

	private void method_visitor ( MethodHandler mh ) {
		this.type_doc.start_detail_method ( );
		mh.visit_methods ( this );
		this.type_doc.end_detail_method ( );
	}

	private void construction_methods_visitor ( ConstructionMethodHandler cmh ) {
		this.type_doc.start_detail_construction_method ( );
		cmh.visit_construction_methods ( this );
		this.type_doc.end_detail_construction_method ( );
	}

	private void field_visitor ( Valadoc.FieldHandler fh ) {
		this.type_doc.start_detail_field ( );
		fh.visit_fields ( this );
		this.type_doc.end_detail_field ( );
	}

	private void delegate_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_delegates.html";
		string title = "Delegates:";

		this.del_index = new IndexFile ( path );
		this.del_index.start_file ( this.pkg, "", "../../" );
		this.del_index.open_point ( title, "delegates.html" );

		this.main_index.open_point ( title, this.ns_name + "/index_delegates.html" );
		this.ns_index.open_point ( title, "index_delegates.html" );

		this.del_doc = new DocFile ( this.settings.path + this.file_name + "/" + this.ns_name + "/delegates.html",
																	this.settings );

		this.del_doc.initialisation ( );
		this.del_doc.start_file ( this.pkg, "", "../../" );
		this.del_doc.index_start_synopsis ( );
		
		foreach ( Delegate del in ns.get_delegate_list() )
			this.del_doc.index_add_delegate ( del );

		this.del_doc.index_end_synopsis ( );
		this.del_doc.start_detail ( );

		ns.visit_delegates ( this );

		this.del_index.close_point ( );
		this.del_index.end_file ( );
		this.del_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );

		this.del_doc.end_detail ( );
		this.del_doc.end_file ( );
		this.del_doc = null;
		this.path = null;
	}

	private void error_domain_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_error_domains.html";
		string title = "Errordomains:";

		this.er_index = new IndexFile ( path );
		this.er_index.start_file ( this.pkg, "", "../../" );
		this.er_index.open_point ( title, "" );

		this.main_index.open_point ( title, this.ns_name + "/index_error_domains.html" );
		this.ns_index.open_point ( title, "index_error_domains.html" );

		ns.visit_error_domains ( this );

		this.er_index.close_point ( );
		this.er_index.end_file ( );
		this.er_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );
		this.path = null;
	}

	private void enum_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_enums.html";
		string title = "Enums:";

		this.en_index = new IndexFile ( path );
		this.en_index.start_file ( this.pkg, "", "../../" );
		this.en_index.open_point ( title, "" );

		this.main_index.open_point ( title, this.ns_name + "/index_enums.html" );
		this.ns_index.open_point ( title, "index_enums.html" );

		ns.visit_enums ( this );

		this.en_index.close_point ( );
		this.en_index.end_file ( );
		this.en_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );
		this.path = null;
	}

	private void interface_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_classes.html";
		string title = "Interfaces:";

		this.iface_index = new IndexFile ( path );
		this.iface_index.start_file ( this.pkg, "", "../../" );
		this.iface_index.open_point ( title, "" );

		this.main_index.open_point ( title, "" );
		this.ns_index.open_point ( title, "" );

		ns.visit_interfaces ( this );

		this.iface_index.close_point ( );
		this.iface_index.end_file ( );
		this.iface_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );
		this.path = null;
	}

	private void global_class_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_classes.html";
		string title = "Classes:";

		this.cl_index = new IndexFile ( path );
		this.cl_index.start_file ( this.pkg, "", "../../" );
		this.cl_index.open_point ( title, "" );

		this.main_index.open_point ( title, this.ns_name + "/index_classes.html" );
		this.ns_index.open_point ( title, "index_classes.html" );

		ns.visit_classes ( this );

		this.cl_index.close_point ( );
		this.cl_index.end_file ( );
		this.cl_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );
		this.path = null;
	}

	private void global_struct_visitor ( Namespace ns ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + "index_structs.html";
		string title = "Structs:";

		this.stru_index = new IndexFile ( path );
		this.stru_index.start_file ( this.pkg, "", "../../" );
		this.stru_index.open_point ( title, "" );

		this.main_index.open_point ( title, this.ns_name + "/index_structs.html" );
		this.ns_index.open_point ( title, "index_structs.html" );

		ns.visit_structs ( this );

		this.stru_index.close_point ( );
		this.stru_index.end_file ( );
		this.stru_index = null;

		this.main_index.close_point ( );
		this.ns_index.close_point ( );
		this.path = null;
	}

	private void signal_visitor ( SignalHandler sigh ) {
		this.type_doc.start_detail_signal ( );
		sigh.visit_signals ( this );
		this.type_doc.end_detail_signal ( );
	}

	private void namespace_visitor ( ) {
	
	}

	public virtual void visit_file ( File file ) {
		this.file_name = Path.get_basename ( file.name );
		if ( this.file_name.has_suffix ( ".vapi" ) ) {
			var size = this.file_name.size() - ".vapi".size();
			this.pkg = this.file_name.ndup ( size );
		}
		else {
			this.pkg = this.file_name;
		}
		this.pkg += " Reference Manual";

		var rt = DirUtils.create ( this.settings.path + this.file_name, 0777 );
		var path = this.file_name + "/index.html";

		this.main_index = new IndexFile ( this.settings.path + path );
		this.main_index.start_file ( this.pkg, "", "../" );
		this.ns_view_index.add_file ( file.name, path );

		file.visit_namespaces ( this );

		this.ns_view_index.delete ( );
		this.main_index.end_file ( );
		this.main_index = null;
		this.file_name = null;
	}

	public virtual void visit_namespace ( Namespace ns ) {
		var full_name = ns.full_name;

		string title = ( ns.name == null )? "Global Namespace:" : full_name;
		string name = ( ns.name == null )? "(Global)" : full_name;
		this.ns_name = name;

		string path = name + "/index.html";

		this.main_index.open_point ( title, path );

		var rt = DirUtils.create ( this.settings.path + this.file_name + "/" + name, 0777 );
		this.ns_index = new IndexFile ( this.settings.path + this.file_name + "/" + path );
		this.ns_index.start_file ( this.pkg, "", "../../" );
		this.ns_index.open_point ( title, path );

		this.ns_view_index.add_namespace ( this.file_name, full_name, "../" + this.path );

		this.global_field_visitor ( ns );
		this.globa_method_visitor ( ns );
		this.delegate_visitor ( ns );

		this.enum_visitor ( ns );
		this.error_domain_visitor ( ns );
		this.global_struct_visitor ( ns );
		this.interface_visitor ( ns );
		this.global_class_visitor ( ns );

		this.main_index.close_point ( );
		this.ns_index.close_point ( );
		this.ns_index.end_file ( );
		this.ns_index = null;

		ns.visit_namespaces ( this );
	}

	public virtual void visit_interface ( Interface iface ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + iface.name + ".htm";

		this.main_index.add_point ( iface.name, "../../" + path );
		this.iface_index.add_point ( iface.name, "../../../" + path );
		this.ns_index.add_point ( iface.name, "../../../" + path );

		this.type_doc = new DocFile ( path, this.settings );
		this.type_doc.initialisation ( );
		this.type_doc.start_file ( this.pkg, "", "../../" );
		this.type_doc.index_start_synopsis ( );
		this.type_doc.index_start_interface ( iface );

		this.ns_view_index.add_interface ( this.file_name, iface.nspace.full_name, iface.name, "../" + path );

		var methods = iface.get_method_list();
		var properties = iface.get_property_list();
		var signals = iface.get_signal_list();

		int[] space_lst = new int[3];
		space_lst[0] = properties.size;
		space_lst[1] = signals.size;
		space_lst[2] = methods.size;

		foreach ( Property prop in properties ) {
			this.type_doc.index_add_property ( prop );
		}

		this.type_doc.index_space ( space_lst, 0 );

		foreach ( Signal sig in signals ) {
			this.type_doc.index_add_signal ( sig );
		}

		this.type_doc.index_space ( space_lst, 1 );

		foreach ( Method m in methods ) {
			this.type_doc.index_add_method ( m, iface );
		}

		this.type_doc.index_end_interface ( );
		this.type_doc.index_end_synopsis ( );


		this.type_doc.start_description ( iface );
		this.type_doc.start_detail ( );

		this.signal_visitor ( iface );
		this.property_visitor ( iface );
		this.method_visitor ( iface );

		this.type_doc.end_detail ( );
		this.type_doc.end_description ( );
		this.type_doc.end_file ( );
		this.type_doc = null;
		this.path = null;
	}

	private inline void class_synopsis ( Class cl ) {
		var methods = cl.get_method_list();
		var signals = cl.get_signal_list();
		var construction_methods = cl.get_construction_method_list();
		var properties = cl.get_property_list();
		var fields = cl.get_field_list();
		var structs = cl.get_struct_list();
		var classes = cl.get_class_list();

		int[] space_lst = new int[7];
		space_lst[0] = classes.size;
		space_lst[1] = structs.size;
		space_lst[2] = fields.size;
		space_lst[3] = properties.size;
		space_lst[4] = construction_methods.size;
		space_lst[5] = signals.size;
		space_lst[6] = methods.size;

		this.type_doc.index_start_class ( cl );

		foreach ( Class cl in classes ) {
			this.class_synopsis ( cl );
		}

		this.type_doc.index_space ( space_lst, 0 );

		foreach ( Struct stru in structs ) {
			this.struct_synopsis ( stru );
		}

		this.type_doc.index_space ( space_lst, 1 );

		foreach ( Field f in fields ) {
			this.type_doc.index_add_field ( f, cl );
		}

		this.type_doc.index_space ( space_lst, 2 );

		foreach ( Property prop in properties ) {
			this.type_doc.index_add_property ( prop );
		}

		this.type_doc.index_space ( space_lst, 3 );


		foreach ( Method m in construction_methods ) {
			this.type_doc.index_add_method ( m, cl );
		}

		this.type_doc.index_space ( space_lst, 4 );

		foreach ( Signal sig in signals ) {
			this.type_doc.index_add_signal ( sig );
		}

		this.type_doc.index_space ( space_lst, 5 );

		foreach ( Method m in methods ) {
			this.type_doc.index_add_method ( m, cl );
		}

		this.type_doc.index_end_class ( cl );
	}

	public virtual void visit_class ( Class cl ) {
		if ( cl.bracket_level == 0 ) {
			this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
			this.root_class = cl.name;

			string path = this.path + this.root_class + ".htm";
			this.main_index.add_point ( cl.name, "../../" + path );
			this.cl_index.add_point ( cl.name, "../../../" + path );
			this.ns_index.add_point ( cl.name, "../../../" + path );

			this.ns_view_index.add_class ( this.file_name, cl.nspace.full_name, cl.name, "../" + path );

			this.type_doc = new DocFile ( path, this.settings );
			this.type_doc.initialisation ( );
			this.type_doc.start_file ( this.pkg, "", "../../" );

			this.type_doc.index_start_synopsis ( );
			this.class_synopsis ( cl );
			this.type_doc.index_end_synopsis ( );
		}

		this.type_doc.start_type_detail ( cl.name ); // rename to description
		this.type_doc.add_description ( cl );
		this.type_doc.start_detail ( );

		this.construction_methods_visitor ( cl );
		this.field_visitor ( cl );
		this.signal_visitor ( cl );
		this.property_visitor ( cl );
		this.method_visitor ( cl );

		this.type_doc.end_detail ( );
		this.type_doc.end_type_detail ( );

		cl.visit_classes ( this );
		cl.visit_structs ( this );

		if ( cl.bracket_level == 0 ) {
			this.type_doc.end_file ( );
			this.root_class = null;
			this.path = null;
		}
	}

	private void struct_synopsis ( Struct stru ) {
		var construction_methods = stru.get_construction_method_list();
		var methods = stru.get_method_list();
		var fields = stru.get_field_list();

		int[] space_lst = new int[3];
		space_lst[0] = fields.size;
		space_lst[1] = construction_methods.size;
		space_lst[2] = methods.size;

		this.type_doc.index_start_struct ( stru );

		foreach ( Field f in fields ) {
			if ( f.is_visitor_accessible() )
				this.type_doc.index_add_field ( f, stru );
		}

		this.type_doc.index_space ( space_lst, 0 );

		foreach ( Method m in construction_methods ) {
			this.type_doc.index_add_method ( m, stru );
		}

		this.type_doc.index_space ( space_lst, 1 );

		foreach ( Method m in methods ) {
			this.type_doc.index_add_method ( m, stru );
		}

		this.type_doc.index_end_struct ( stru );
	}

	public virtual void visit_struct ( Struct stru ) {
		if ( stru.bracket_level == 0 ) {
			this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
			this.root_class = stru.name;

			string path = this.path + this.root_class + ".htm";
			this.main_index.add_point ( stru.name, "../../" + path );
			this.stru_index.add_point ( stru.name, "../../../" + path );
			this.ns_index.add_point ( stru.name, "../../../" + path );

			this.ns_view_index.add_struct ( this.file_name, stru.nspace.full_name, stru.name, "../" + path );

			this.type_doc = new DocFile ( path, this.settings );
			this.type_doc.initialisation ( );
			this.type_doc.start_file ( this.pkg, "", "../../" );

			this.type_doc.index_start_synopsis ( );
			this.struct_synopsis ( stru );
			this.type_doc.index_end_synopsis ( );

			this.type_doc.start_type_detail ( "" );
			this.type_doc.add_description ( stru );
			this.type_doc.start_detail ( );
		}
		else {
			this.type_doc.start_type_detail ( stru.name );
			this.type_doc.add_description ( stru );
			this.type_doc.start_detail ( );
		}

		//stru.visit_construction_methods ( this );
		this.construction_methods_visitor ( stru );

		this.field_visitor ( stru );
		//stru.visit_methods ( this );
		this.method_visitor ( stru );

		if ( stru.bracket_level != 0 ) {
			this.type_doc.end_detail ( );
			this.type_doc.end_type_detail ( );
			return ;
		}

		this.type_doc.end_detail ( );
		this.type_doc.end_file ( );
		this.type_doc = null;
		this.path = null;
	}

	public virtual void visit_error_domain ( ErrorDomain errdom ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + errdom.name + ".htm";

		this.er_index.add_point ( errdom.name, "../../../" + path );
		this.main_index.add_point ( errdom.name, "../../" + path );
		this.ns_index.add_point ( errdom.name, "../../../" + path );

		this.type_doc = new DocFile ( path, this.settings );
		this.type_doc.initialisation ( );
		this.type_doc.start_file ( this.pkg, "", "../../" );
		this.type_doc.index_start_synopsis ( );

		this.type_doc.index_start_error_domain ( errdom );

		var errcodes = errdom.get_error_code_list();
		var methods = errdom.get_method_list();

		int[] space_lst = new int[2];
		space_lst[0] = errcodes.size;
		space_lst[1] = methods.size;

		foreach ( ErrorCode errcode in errcodes ) {
			this.type_doc.index_add_error_code ( errcode );
		}

		this.type_doc.index_space ( space_lst, 0 );

		foreach ( Method m in methods ) {
			if ( m.is_visitor_accessible() )
				this.type_doc.index_add_method ( m, errdom );
		}

		this.type_doc.index_end_error_domain ( );
		this.type_doc.index_end_synopsis ( );
		this.type_doc.start_description ( errdom );


		this.ns_view_index.add_error_domain ( this.file_name, errdom.nspace.full_name, errdom.name, "../" + path );


		this.type_doc.start_detail_error_code ( );
		errdom.visit_error_codes ( this );
		this.type_doc.end_detail_error_code ( );

		this.method_visitor ( errdom );

		this.type_doc.end_file ( );
		this.type_doc.end_description ( );
		this.type_doc = null;
		this.path = null;
	}

	public virtual void visit_enum ( Enum en ) {
		this.path = this.settings.path + this.file_name + "/" + this.ns_name + "/";
		string path = this.path + en.name + ".htm";

		this.en_index.add_point ( en.name, "../../../" + path );
		this.main_index.add_point ( en.name, "../../" + path );
		this.ns_index.add_point ( en.name, "../../../" + path );

		this.type_doc = new DocFile ( path, this.settings );
		this.type_doc.initialisation ( );
		this.type_doc.start_file ( this.pkg, "", "../../" );
		this.type_doc.index_start_synopsis ( );

		this.type_doc.index_start_enum ( en );

		var envals = en.get_enum_values( );
		var methods = en.get_method_list( );


		int[] space_lst = new int[2];
		space_lst[0] = envals.size;
		space_lst[1] = methods.size;


		foreach ( EnumValue enval in envals ) {
			this.type_doc.index_add_enum_value ( enval );
		}

		this.type_doc.index_space ( space_lst, 0 );

		foreach ( Method m in methods ) {
				this.type_doc.index_add_method ( m, en );
		}

		this.type_doc.index_end_enum ( );
		this.type_doc.index_end_synopsis ( );

		this.type_doc.start_description ( en );
		this.ns_view_index.add_enum ( this.file_name, en.nspace.full_name, en.name, "../" + path );


		this.type_doc.start_detail_enum_value ( );
		en.visit_enum_values ( this );
		this.type_doc.end_detail_enum_value ( );

		this.method_visitor ( en );

		this.type_doc.end_file ( );
		this.type_doc.end_description ( );
		this.type_doc = null;
		this.path = null;
	}

	public virtual void visit_property ( Property prop ) {
		this.type_doc.add_detail_property ( prop );
	}

	public virtual void visit_field ( Field field, FieldHandler parent ) {
		if ( field.is_global ) {
			string path = this.path + "globals.html";
			this.ns_index.add_point ( field.name, "../../../" + path + "#" + this.get_mark_name ( field ) );
			this.main_index.add_point ( field.name, "../../" + path + "#" + this.get_mark_name ( field ) );
			this.global_var_index.add_point ( field.name, "../../../" + path + "#" + this.get_mark_name ( field ) );

			this.ns_view_index.add_global_field ( this.file_name, field.nspace.full_name, field.name,
				"../" + path + "#" + this.get_mark_name ( field ) );

			this.glob_doc.add_detail_field( field, parent );
			return ;
		}

		this.type_doc.add_detail_field ( field, parent );
	}

	public virtual void visit_error_code ( ErrorCode errcode ) {
		this.type_doc.add_detail_error_code ( errcode );
	}

	public virtual void visit_enum_value ( EnumValue enval ) {
		this.type_doc.add_detail_enum_value ( enval );
		//this.type_doc.add_description ( enval );
	}

	public virtual void visit_delegate ( Delegate del ) {
		string path = this.path + "delegates.html";
		this.main_index.add_point ( del.name, "../../" + path + "#" + this.get_mark_name ( del ) );
		this.del_index.add_point ( del.name, "../../../" + path + "#" + this.get_mark_name ( del ) );
		this.ns_index.add_point ( del.name, "../../../" + path + "#" + this.get_mark_name ( del ) );

		this.del_doc.add_detail_delegate ( del );

		this.ns_view_index.add_delegate ( this.file_name, del.nspace.full_name, del.name,
			"../" + path + "#" + this.get_mark_name ( del ) );
	}

	public virtual void visit_signal ( Signal sig ) {
		this.type_doc.add_detail_signal ( sig );
	}

	public virtual void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		if ( m.is_global ) {
			string path = this.path + "functions.html";
			this.ns_index.add_point ( m.name, "../../../" + path + "#" + this.get_mark_name ( m ) );
			this.main_index.add_point ( m.name, "../../" + path + "#" + this.get_mark_name ( m ) );
			this.function_index.add_point ( m.name, "../../../" + path + "#" + this.get_mark_name ( m ) );

			this.func_doc.add_detail_method ( m, parent );
			this.ns_view_index.add_global_method ( this.file_name, m.nspace.full_name, m.name,
				"../" + path + "#" + this.get_mark_name ( m ) );
			return ;
		}

		this.type_doc.add_detail_method ( m, parent );
	}
}

