/* taglet.vala
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

using Gee;
using Valadoc.Content;


public class Valadoc.Taglets.Param : InlineContent, Taglet, Block {
	public string parameter_name { internal set; get; }

	public weak Api.Symbol? parameter { private set; get; }

	public int position { private set; get; default = -1; }

	public Rule? get_parser_rule (Rule run_rule) {
		return Rule.seq ({
			Rule.option ({ Rule.many ({ TokenType.SPACE }) }),
			TokenType.any_word ().action ((token) => { parameter_name = token.to_string (); }),
			run_rule
		});
	}


	public override void check (Api.Tree api_root, Api.Node container, string file_path, ErrorReporter reporter, Settings settings) {
		// Check for the existence of such a parameter
		this.parameter = null;

		if (parameter_name == "...") {
			Gee.List<Api.Node> params = container.get_children_by_type (Api.NodeType.FORMAL_PARAMETER, false);
			foreach (Api.Node param in params) {
				if (((Api.FormalParameter) param).ellipsis) {
					this.parameter = (Api.Symbol) param;
					this.position = params.size - 1;
					break;
				}
			}
		} else {
			Gee.List<Api.Node> params = container.get_children_by_types ({Api.NodeType.FORMAL_PARAMETER, Api.NodeType.TYPE_PARAMETER}, false);
			int pos = 0;

			foreach (Api.Node param in params) {
				if (param.name == parameter_name) {
					this.parameter = (Api.Symbol) param;
					this.position = pos;
					break;
				}

				pos++;
			}
		}

		if (this.parameter == null) {
			reporter.simple_warning ("%s: %s: @param: warning: Unknown parameter `%s'", file_path, container.get_full_name (), parameter_name);
		}

		base.check (api_root, container, file_path, reporter, settings);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_taglet (this);
	}
}
