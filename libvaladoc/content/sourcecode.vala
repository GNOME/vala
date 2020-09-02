/* sourcecode.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2012 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


public class Valadoc.Content.SourceCode : ContentElement, Inline {
	public enum Language {
		UNKNOWN,
		GENIE,
		VALA,
		XML,
		C;

		public static Language from_path (string path) {
			int pos = path.last_index_of (".");
			if (pos < 0) {
				return Language.UNKNOWN;
			}

			string ext = path.substring (pos + 1);
			return from_string (ext, true);
		}

		public static Language from_string (string str, bool is_extension = false) {
			switch (str) {
			case "genie":
				if (is_extension) {
					return Language.UNKNOWN;
				}
				return Language.GENIE;
			case "gs":
				return Language.GENIE;
			case "xml":
				return Language.XML;
			case "vala":
				return Language.VALA;
			case "c":
			case "h":
				return Language.C;
			}

			return Language.UNKNOWN;
		}

		public unowned string to_string () {
			switch (this) {
			case Language.GENIE:
				return "genie";
			case Language.VALA:
				return "vala";
			case Language.XML:
				return "xml";
			case Language.C:
				return "c";
			}

			assert_not_reached ();
		}
	}


	public string code {
		get;
		set;
	}

	public Run? highlighted_code {
		get;
		private set;
	}

	public Language language {
		get;
		set;
	}

	internal SourceCode () {
		base ();
		_language = Language.VALA;
	}

	private string? get_path (string path, Api.Node container, string source_file_path,
							  ErrorReporter reporter)
	{
		// search relative to our file
		if (!Path.is_absolute (path)) {
			string relative_to_file = Path.build_path (Path.DIR_SEPARATOR_S,
													   Path.get_dirname (source_file_path),
													   path);
			if (FileUtils.test (relative_to_file, FileTest.EXISTS | FileTest.IS_REGULAR)) {
				return (owned) relative_to_file;
			}
		}

		// search relative to the current directory / absolute path
		if (!FileUtils.test (path, FileTest.EXISTS | FileTest.IS_REGULAR)) {
			string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
			code = "File '%s' does not exist".printf (path);
			reporter.simple_warning ("%s: %s{{{".printf (source_file_path, node_segment),
									 "%s", code);
			return null;
		}

		return path;
	}

	private void load_source_code (string _path, Api.Node container, string source_file_path,
								   ErrorReporter reporter)
	{
		string? path = get_path (_path, container, source_file_path, reporter);
		if (path == null) {
			return ;
		}

		try {
			string content = null;
			FileUtils.get_contents (path, out content);
			_language = Language.from_path (path);
			code = (owned) content;
		} catch (FileError err) {
			string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
			reporter.simple_error ("%s: %s{{{".printf (source_file_path, node_segment),
								   "Can't read file '%s': %s", path, err.message);
		}
	}

	private inline bool is_empty_string (string line) {
		for (int i = 0; line[i] != '\0'; i++) {
			if (line[i].isspace () == false) {
				return false;
			}
		}

		return true;
	}

	private string strip_code (string code) {
		string[] lines = code.split ("\n");
		for (int i = lines.length - 1; i >= 0 && is_empty_string (lines[i]); i--) {
			lines[i] = null;
		}

		string** _lines = lines;
		for (int i = 0; lines[i] != null && is_empty_string (lines[i]); i++) {
			_lines = &lines[i + 1];
		}

		return string.joinv ("\n", (string[]) _lines);
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		string[] splitted = code.split ("\n", 2);
		if (splitted[0].strip () == "") {
			code = splitted[1] ?? "";
		} else if (splitted[0].has_prefix ("#!")) {
			unowned string start = (string) (((char*) splitted[0]) + 2);
			if (start.has_prefix ("include:")) {
				start = (string) (((char*) start) + 8);
				string path = start.strip ();
				load_source_code (path, container, file_path, reporter);
			} else {
				string name = start._strip ().ascii_down ();
				_language = Language.from_string (name);
				code = splitted[1] ?? "";
				if (_language == Language.UNKNOWN && name != "none") {
					string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
					reporter.simple_warning ("%s: %s{{{".printf (file_path, node_segment),
						"Unsupported programming language '%s'", name);
				}
			}
		}

		code = strip_code (code);

		if (_language == Language.VALA) {
			highlighted_code = api_root.highlighter.highlight_vala (code);
		} else if (_language == Language.XML) {
			highlighted_code = api_root.highlighter.highlight_xml (code);
		} else if (_language == Language.C) {
			highlighted_code = api_root.highlighter.highlight_c (code);
		} else {
			highlighted_code = new Run (Run.Style.MONOSPACED);
			highlighted_code.content.add (new Text (code));
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_source_code (this);
	}

	public override void accept_children (ContentVisitor visitor) {
		if (highlighted_code != null) {
			highlighted_code.accept (visitor);
		}
	}

	public override bool is_empty () {
		// empty source blocks are visible as well
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		SourceCode source_code = new SourceCode ();
		source_code.parent = new_parent;

		source_code.language = language;
		source_code.code = code;

		return source_code;
	}
}
