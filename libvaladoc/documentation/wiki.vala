/* wiki.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
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


	public Api.Package? package {
		get {
			return _package;
		}
	}

	private Api.Package _package;

	/**
	 * The corresponding file name
	 */
	public string? get_filename () {
		return Path.get_basename(this.path);
	}

	public WikiPage (string name, string path, Api.Package package) {
		this._package = package;
		this.name = name;
		this.path = path;
	}

	public void read (ErrorReporter reporter) {
		try {
			string content;
			FileUtils.get_contents (this.path, out content);
			this.documentation_str = content;
		} catch (FileError err) {
			reporter.simple_error (null, "Unable to read file '%s': %s", this.path, err.message);
		}
	}

	public void parse (DocumentationParser docparser, Api.Package pkg) {
		documentation = docparser.parse_wikipage (pkg, this);
	}
}


public class Valadoc.WikiPageTree : Object {
	private Vala.ArrayList<WikiPage> wikipages;


	public WikiPageTree () {
	}

	public Vala.Collection<WikiPage> get_pages () {
		return this.wikipages == null ? new Vala.ArrayList<WikiPage> () : this.wikipages;
	}

	public WikiPage? search (string name) {
		if (this.wikipages == null) {
			return null;
		}

		foreach (WikiPage page in this.wikipages ) {
			if (page.name == name) {
				return page;
			}
		}
		return null;
	}

	private void create_tree_from_path (DocumentationParser docparser, Api.Package package,
										ErrorReporter reporter, string path, string? nameoffset = null)
	{
		try {
			Dir dir = Dir.open (path);

			for (string? curname = dir.read_name (); curname!=null ; curname = dir.read_name ()) {
				string filename = Path.build_filename (path, curname);
				if (curname.has_suffix (".valadoc") && FileUtils.test (filename, FileTest.IS_REGULAR)) {
					WikiPage wikipage = new WikiPage ((nameoffset!=null)
						? Path.build_filename (nameoffset, curname)
						: curname, filename, package);
					this.wikipages.add(wikipage);
					wikipage.read (reporter);
				} else if (FileUtils.test (filename, FileTest.IS_DIR)) {
					this.create_tree_from_path (docparser, package, reporter, filename, (nameoffset!=null)
						? Path.build_filename (nameoffset, curname)
						: curname);
				}
			}
		} catch (FileError err) {
			reporter.simple_error (null, "Unable to open directory '%s': %s", path, err.message);
		}
	}

	public void parse (Settings settings, DocumentationParser docparser, Api.Package package, ErrorReporter reporter) {
		weak string path = settings.wiki_directory;
		if (path == null) {
			return ;
		}

		this.wikipages = new Vala.ArrayList<WikiPage> ();
		this.create_tree_from_path (docparser, package, reporter, path);

		foreach (WikiPage page in this.wikipages) {
			page.parse (docparser, package);
		}
	}

	public void check (Settings settings, DocumentationParser docparser, Api.Package pkg) {
		if (this.wikipages == null) {
			return ;
		}

		foreach (WikiPage page in this.wikipages) {
			docparser.check_wikipage (pkg, page);
		}
	}
}


