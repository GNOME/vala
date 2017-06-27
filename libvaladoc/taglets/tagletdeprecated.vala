/* tagletdeprecated.vala
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


using Valadoc.Content;

public class Valadoc.Taglets.Deprecated : BlockContent, Taglet, Block {
	public Rule? get_parser_rule (Rule run_rule) {
		return run_rule;
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		base.check (api_root, container, file_path, reporter, settings);
		reporter.simple_warning ("%s: %s: @deprecated".printf (file_path, container.get_full_name ()),
								 "@deprecated is deprecated. Use [Version (deprecated = true)]");
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_taglet (this);
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Deprecated deprecated = new Deprecated ();
		deprecated.parent = new_parent;

		foreach (Block element in content) {
			Block copy = element.copy (deprecated) as Block;
			deprecated.content.add (copy);
		}

		return deprecated;
	}
}

