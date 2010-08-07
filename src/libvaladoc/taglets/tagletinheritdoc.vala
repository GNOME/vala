/* tagletinheritdoc.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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

using Gee;
using Valadoc.Content;

public class Valadoc.Taglets.InheritDoc : InlineTaglet {
	private Api.Node? _inherited;

	public override Rule? get_parser_rule (Rule run_rule) {
		return null;
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
		// TODO Check that the container is an override of an abstract symbol
		// Also retrieve that abstract symbol _inherited

		if (container is Api.Method) {
			_inherited = ((Api.Method) container).base_method;
		} else if (container is Api.Property) {
			_inherited = ((Api.Property) container).base_property;
		}

		// TODO report error if inherited is null

		// TODO postpone check after complete parse of the api tree comments
		// And reenable that check
		//base.check (api_root, container, reporter);
	}

	public override ContentElement produce_content () {
		if (_inherited != null) {
			Paragraph inherited_paragraph = _inherited.documentation.content.get (0) as Paragraph;

			Run paragraph = new Run (Run.Style.NONE);
			foreach (var element in inherited_paragraph.content) {
				paragraph.content.add (element);
			}
			return paragraph;
		}
		return new Text ("");
	}
}
