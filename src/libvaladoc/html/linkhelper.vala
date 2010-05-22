/* linkhelper.vala
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

using Gee;



public class Valadoc.Html.LinkHelper : Object {
	private static LinkHelper _singleton;
	private Settings _settings = null;

	private LinkHelper () {
	}

	public static LinkHelper get_instance () {
		if (_singleton == null) {
			_singleton = new LinkHelper ();
		}

		return _singleton;
	}

	public string? get_package_link (Api.Package package, Settings settings) {
		if (!package.is_browsable (settings)) {
			return null;
		}

		return Path.build_filename (package.name, "index.htm");
	}

	public string? get_relative_link (Documentation from, Documentation to, Settings settings) {
		_settings = settings;

		//TODO: find a better solution which does not require too much code ...
		if (from is Api.Package) {
			if (to is Api.Package) {
				return from_package_to_package ((Api.Package) from, (Api.Package) to);
			} else if (to is Api.Node) {
				return from_package_to_node ((Api.Package) from, (Api.Node) to);
			} else if (to is WikiPage) {
				return from_package_to_wiki ((Api.Package) from, (WikiPage) to);
			} else {
				assert (true);
			}
		} else if (from is Api.Node) {
			if (to is Api.Package) {
				return from_node_to_package ((Api.Node) from, (Api.Package) to);
			} else if (to is Api.Node) {
				return from_node_to_node ((Api.Node) from, (Api.Node) to);
			} else if (to is WikiPage) {
				return from_node_to_wiki ((Api.Node) from, (WikiPage) to);
			} else {
				assert (true);
			}
		} else if (from is WikiPage) {
			if (to is Api.Package) {
				return from_wiki_to_package ((WikiPage) from, (Api.Package) to);
			} else if (to is Api.Node) {
				return from_wiki_to_node ((WikiPage) from, (Api.Node) to);
			} else if (to is WikiPage) {
				return from_wiki_to_wiki ((WikiPage) from, (WikiPage) to);
			} else {
				assert (true);
			}
		} else {
			assert (true);
		}

		return null;
	}

	private string translate_wiki_name (WikiPage page) {
		var name = page.name;

		return name.ndup (name.pointer_to_offset (name.chr (-1, '.'))).replace ("/", ".") + ".html";
	}




	protected virtual string? from_package_to_package (Api.Package from, Api.Package to) {
		if (!to.is_browsable(_settings)) {
			return null;
		}

		if (from == to) {
			return "#";
		} else {
			return Path.build_filename ("..", to.name, "index.htm");
		}
	}

	protected virtual string? from_package_to_wiki (Api.Package from, WikiPage to) {
		if (from.name == "index.valadoc") {
			return Path.build_filename ("..", "index.html");
		} else {
			return Path.build_filename ("..", "content", translate_wiki_name (to));
		}
	}

	protected virtual string? from_package_to_node (Api.Package from, Api.Node to) {
		if (!to.is_browsable(_settings) || !to.package.is_browsable (_settings)) {
			return null;
		}

		if (from == to.package) {
			return Path.build_filename (to.get_full_name () + ".html");
		} else {
			return Path.build_filename ("..", to.package.name, to.get_full_name () + ".html");
		}
	}



	protected virtual string? from_wiki_to_package (WikiPage from, Api.Package to) {
		if (!to.is_browsable(_settings)) {
			return null;
		}

		if (from.name == "index.valadoc") {
			return Path.build_filename (to.name, "index.htm");
		} else {
			return Path.build_filename ("..", to.name, "index.htm");
		}
	}

	protected virtual string? from_wiki_to_wiki (WikiPage from, WikiPage to) {
		if (from == to) {
			return "#";
		} else if (from.name == "index.valadoc") {
			return Path.build_filename ("content", translate_wiki_name (to));
		} else if (to.name == "index.valadoc") {
			return Path.build_filename ("..", "index.html");
		} else {
			return translate_wiki_name (to);
		}
	}

	protected virtual string? from_wiki_to_node (WikiPage from, Api.Node to) {
		if (!to.is_browsable(_settings) || !to.package.is_browsable (_settings)) {
			return null;
		}

		if (from.name == "index.valadoc") {
			return Path.build_filename (to.package.name, to.get_full_name() + ".html");
		} else {
			return Path.build_filename ("..", to.package.name, to.get_full_name() + ".html");
		}
	}



	protected virtual string? from_node_to_package (Api.Node from, Api.Package to) {
		if (!to.is_browsable (_settings)) {
			return null;
		}

		if (from.package == to) {
			return "index.htm";
		} else {
			return Path.build_filename ("..", to.name, "index.htm");
		}
	}

	protected virtual string? from_node_to_wiki (Api.Node from, WikiPage to) {
		if (to.name == "index.valadoc") {
			return Path.build_filename ("..", "index.html");
		} else {
			return Path.build_filename ("..", "content", translate_wiki_name (to));
		}
	}

	protected virtual string? from_node_to_node (Api.Node from, Api.Node to) {
		if (!to.is_browsable(_settings) || !to.package.is_browsable (_settings)) {
			return null;
		}

		if (from.package == to.package) {
			return Path.build_filename (to.get_full_name() + ".html");
		} else {
			return Path.build_filename ("..", to.package.name, to.get_full_name() + ".html");
		}
	}
 }

