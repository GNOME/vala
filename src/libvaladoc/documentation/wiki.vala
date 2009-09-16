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


public class Valadoc.WikiPage : Object, Documentation {
	public Content.Page documentation {
		protected set;
		get;
	}

	public string documentation_str {
		private set;
		get;
	}

	public string path {
		private set;
		get;
	}

	public string name {
		private set;
		get;
	}

	public string? get_filename () {
		return Path.get_basename( this.path );
	}

	public WikiPage ( string name, string path ) {
		this.name = name;
		this.path = path;
	}

	public void read ( ) throws GLib.FileError {
		try {
			string content;
			FileUtils.get_contents (this.path, out content);
			this.documentation_str = content;
		}
		catch (FileError err) {
			throw err;
		}
	}

	public bool parse (DocumentationParser docparser) {
		documentation = docparser.parse_wikipage ( this );
		return true;
	}
}


public class Valadoc.WikiPageTree : Object {
	private Gee.ArrayList<WikiPage> wikipages;
	private ErrorReporter reporter;
	private Settings settings;

	public WikiPageTree ( ErrorReporter reporter, Settings settings ) {
		this.reporter = reporter;
		this.settings = settings;
	}

	public Gee.Collection<WikiPage> get_pages () {
		return this.wikipages == null ? Gee.Collection.empty<WikiPage> () : this.wikipages.read_only_view;
	}

	public WikiPage? search ( string name ) {
		if ( this.wikipages == null ) {
			return null;
		}

		foreach ( WikiPage page in this.wikipages ) {
			if ( page.name == name ) {
				return page;
			}
		}
		return null;
	}

	private void create_tree_from_path (DocumentationParser docparser, string path, string? nameoffset = null) throws GLib.FileError {
		Dir dir = Dir.open (path);

		for (string? curname = dir.read_name(); curname!=null ; curname = dir.read_name()) {
			string filename = Path.build_filename (path, curname);
			if ( curname.has_suffix(".valadoc") && FileUtils.test(filename, FileTest.IS_REGULAR) ) {
				WikiPage wikipage = new WikiPage( (nameoffset!=null)?Path.build_filename (nameoffset, curname):curname, filename );
				this.wikipages.add(wikipage);
				wikipage.read ();
			}
			else if ( FileUtils.test(filename, FileTest.IS_DIR) ) {
				this.create_tree_from_path (docparser, filename, (nameoffset!=null)?Path.build_filename (nameoffset, curname):curname);
			}
		}
	}

	public void create_tree ( DocumentationParser docparser ) throws GLib.FileError {
		try {
			weak string path = this.settings.wiki_directory;
			if (path == null) {
				return ;
			}

			this.wikipages = new Gee.ArrayList<WikiPage> ();
			this.create_tree_from_path (docparser, path);

			foreach ( WikiPage page in this.wikipages ) {
				page.parse ( docparser );
			}
		}
		catch (FileError err) {
			throw err;
		}
	}
}


