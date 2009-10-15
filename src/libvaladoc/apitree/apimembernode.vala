/* apitypesymbolnode.vala
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

using Gee;


public abstract class Valadoc.Api.MemberNode : Api.SymbolNode {

	public MemberNode (Vala.Member symbol, Api.Node parent) {
		base (symbol, parent);
	}

	protected override void process_comments (Settings settings, DocumentationParser parser) {
		var source_comment = ((Vala.Member) symbol).comment;
		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.process_comments (settings, parser);
	}
}

