/* tagletinheritdoc.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using GLib;
using Gee;
using Valadoc.Content;

public class Valadoc.Taglets.InheritDoc : InlineTaglet {
	private Api.Node? _inherited;

	public override Rule? get_parser_rule (Rule run_rule) {
		return null;
	}

	public override void check (Tree api_root, Api.Node? container, ErrorReporter reporter) {
		// TODO Check that the container is an override of an abstract symbol
		// Also retrieve that abstract symbol _inherited

		if (container is Method) {
			_inherited = ((Method) container).base_method;
		} else if (container is Property) {
			_inherited = ((Property) container).base_property;
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
