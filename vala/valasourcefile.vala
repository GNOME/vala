/* valasourcefile.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents a Vala source or VAPI package file.
 */
public class Vala.SourceFile {
	/**
	 * The name of this source file.
	 */
	public string filename { get; set; }
	
	public string? relative_filename {
		set {
			this._relative_filename = value;
		}
	}

	/**
	 * Specifies whether this file is a VAPI package file.
	 */
	public SourceFileType file_type { get; set; }

	/**
	 * Specifies whether this file came from the command line directly.
	 */
	public bool from_commandline { get; set; }

	/**
	 *  GIR Namespace for this source file, if it's a VAPI package
	 */

	public string gir_namespace { get; set; }

	/**
	 *  GIR Namespace version for this source file, if it's a VAPI package
	 */

	public string gir_version { get; set; }

	/**
	 * The context this source file belongs to.
	 */
	public weak CodeContext context { get; set; }

	public string? content {
		get { return this._content; }
		set {
			this._content = value;
			this.source_array = null;
		}
	}

	/**
	 * If the file has been used (ie: if anything in the file has
	 * been emitted into C code as a definition or declaration).
	 */
	public bool used { get; set; }

	private ArrayList<Comment> comments = new ArrayList<Comment> ();

	public List<UsingDirective> current_using_directives { get; set; default = new ArrayList<UsingDirective> (); }

	private List<CodeNode> nodes = new ArrayList<CodeNode> ();

	string? _relative_filename;

	private string csource_filename = null;
	private string cinclude_filename = null;

	private ArrayList<string> source_array = null;

	private MappedFile mapped_file = null;

	private string? _content = null;

	/**
	 * Creates a new source file.
	 *
	 * @param filename source file name
	 * @param pkg      true if this is a VAPI package file
	 * @return         newly created source file
	 */
	public SourceFile (CodeContext context, SourceFileType type, string filename, string? content = null, bool cmdline = false) {
		this.context = context;
		this.file_type = type;
		this.filename = filename;
		this.content = content;
		this.from_commandline = cmdline;
	}

	/**
	 * Adds a header comment to this source file.
	 */
	public void add_comment (Comment comment) {
		comments.add (comment);
	}

	/**
	 * Returns a copy of the list of header comments.
	 *
	 * @return list of comments
	 */
	public List<Comment> get_comments () {
		return comments;
	}

	/**
	 * Adds a new using directive with the specified namespace.
	 *
	 * @param ns reference to namespace
	 */
	public void add_using_directive (UsingDirective ns) {
		// do not modify current_using_directives, it should be considered immutable
		// for correct symbol resolving
		var old_using_directives = current_using_directives;
		current_using_directives = new ArrayList<UsingDirective> ();
		foreach (var using_directive in old_using_directives) {
			current_using_directives.add (using_directive);
		}
		current_using_directives.add (ns);
	}

	/**
	 * Adds the specified code node to this source file.
	 *
	 * @param node a code node
	 */
	public void add_node (CodeNode node) {
		nodes.add (node);
	}

	public void remove_node (CodeNode node) {
		nodes.remove (node);
	}

	/**
	 * Returns a copy of the list of code nodes.
	 *
	 * @return code node list
	 */
	public List<CodeNode> get_nodes () {
		return nodes;
	}

	public void accept (CodeVisitor visitor) {
		visitor.visit_source_file (this);
	}

	public void accept_children (CodeVisitor visitor) {
		foreach (CodeNode node in nodes) {
			node.accept (visitor);
		}
	}

	private string get_subdir () {
		if (context.basedir == null) {
			return "";
		}

		// filename and basedir are already canonicalized
		if (filename.has_prefix (context.basedir + "/")) {
			var basename = Path.get_basename (filename);
			var subdir = filename.substring (context.basedir.length, filename.length - context.basedir.length - basename.length);
			while (subdir[0] == '/') {
				subdir = subdir.substring (1);
			}
			return subdir;
		}
		return "";
	}

	private string get_destination_directory () {
		if (context.directory == null) {
			return get_subdir ();
		}
		return Path.build_path ("/", context.directory, get_subdir ());
	}

	private string get_basename () {
		int dot = filename.last_index_of_char ('.');
		return Path.get_basename (filename.substring (0, dot));
	}

	public string get_relative_filename () {
		if (_relative_filename != null) {
			return _relative_filename;
		} else {
			return Path.get_basename (filename);
		}
	}

	/**
	 * Returns the filename to use when generating C source files.
	 *
	 * @return generated C source filename
	 */
	public string get_csource_filename () {
		if (csource_filename == null) {
			if (context.run_output) {
				csource_filename = context.output + ".c";
			} else if (context.ccode_only || context.save_csources) {
				csource_filename = Path.build_path ("/", get_destination_directory (), get_basename () + ".c");
			} else {
				// temporary file
				csource_filename = Path.build_path ("/", get_destination_directory (), get_basename () + ".vala.c");
			}
		}
		return csource_filename;
	}

	/**
	 * Returns the filename to use when including the generated C header
	 * file.
	 *
	 * @return C header filename to include
	 */
	public string get_cinclude_filename () {
		if (cinclude_filename == null) {
			if (context.header_filename != null) {
				cinclude_filename = Path.get_basename (context.header_filename);
				if (context.includedir != null) {
					cinclude_filename = Path.build_path ("/", context.includedir, cinclude_filename);
				}
			} else {
				cinclude_filename = Path.build_path ("/", get_subdir (), get_basename () + ".h");
			}
		}
		return cinclude_filename;
	}

	/**
	 * Returns the requested line from this file, loading it if needed.
	 *
	 * @param lineno 1-based line number
	 * @return       the specified source line
	 */
	public string? get_source_line (int lineno) {
		if (source_array == null) {
			if (content != null) {
				read_source_lines (content);
			} else {
				read_source_file ();
			}
		}
		if (lineno < 1 || lineno > source_array.size) {
			return null;
		}
		return source_array.get (lineno - 1);
	}

	/**
	 * Parses the input file into ::source_array.
	 */
	private void read_source_file () {
		string cont;
		try {
			FileUtils.get_contents (filename, out cont);
		} catch (FileError fe) {
			return;
		}
		read_source_lines (cont);
	}

	private void read_source_lines (string cont)
	{
		source_array = new ArrayList<string> ();
		string[] lines = cont.split ("\n", 0);
		int idx;
		for (idx = 0; lines[idx] != null; ++idx) {
			source_array.add (lines[idx]);
		}
	}

	public char* get_mapped_contents () {
		if (content != null) {
			return (char*) content;
		}

		if (mapped_file == null) {
			try {
				mapped_file = new MappedFile (filename, false);
			} catch (FileError e) {
				Report.error (null, "Unable to map file `%s': %s".printf (filename, e.message));
				return null;
			}
		}

		return mapped_file.get_contents ();
	}
	
	public size_t get_mapped_length () {
		if (content != null) {
			return content.length;
		}

		return mapped_file.get_length ();
	}

	public bool check (CodeContext context) {
		foreach (CodeNode node in nodes) {
			node.check (context);
		}
		return true;
	}
}

public enum Vala.SourceFileType {
	NONE,
	SOURCE,
	PACKAGE,
	FAST
}
