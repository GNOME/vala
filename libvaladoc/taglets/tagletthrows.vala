/* tagletthrows.vala
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

public class Valadoc.Taglets.Throws : BlockContent, Taglet, Block {
	// TODO: rename
	public string error_domain_name { private set; get; }

	/**
	 * Thrown  Error domain or Error code
	 */
	// TODO: rename
	public Api.Node error_domain { private set; get; }

	public Rule? get_parser_rule (Rule run_rule) {
		return Rule.seq ({
			Rule.option ({ Rule.many ({ TokenType.SPACE }) }),
			TokenType.any_word ().action ((token) => { error_domain_name = token.to_string (); }),
			run_rule
		});
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		// context check:
		if (container is Api.Method == false && container is Api.Delegate == false) {
			reporter.simple_warning ("%s: %s: @throws".printf (file_path, container.get_full_name ()),
									 "@throws used outside method/delegate context");
			base.check (api_root, container, file_path, reporter, settings);
			return ;
		}


		// type check:
		error_domain = api_root.search_symbol_str (container, error_domain_name);
		if (error_domain == null) {
			// TODO use ContentElement's source reference
			reporter.simple_error ("%s: %s: @throws".printf (file_path, container.get_full_name ()),
								   "`%s' does not exist", error_domain_name);
			base.check (api_root, container, file_path, reporter, settings);
			return ;
		}


		// Check if the method is allowed to throw the given type or error code:
		Vala.List<Api.Node> exceptions = container.get_children_by_types ({Api.NodeType.ERROR_DOMAIN,
																		  Api.NodeType.CLASS},
																		 false);
		Api.Item expected_error_domain = (error_domain is Api.ErrorCode)
			? error_domain.parent
			: error_domain;
		bool report_warning = true;
		foreach (Api.Node exception in exceptions) {
			if (exception == expected_error_domain
				|| (exception is Api.Class && expected_error_domain is Api.ErrorDomain))
			{
				report_warning = false;
				break;
			}
		}
		if (report_warning) {
			reporter.simple_warning ("%s: %s: @throws".printf (file_path, container.get_full_name ()),
									 "`%s' does not exist in exception list", error_domain_name);
		}

		base.check (api_root, container, file_path, reporter, settings);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_taglet (this);
	}

	public Vala.List<ContentElement>? get_inheritable_documentation () {
		return content;
	}

	public bool inheritable (Taglet taglet) {
		if (taglet is Taglets.Throws == false) {
			return false;
		}

		Taglets.Throws t = (Taglets.Throws) taglet;
		return (error_domain == t.error_domain || error_domain_name == t.error_domain_name);
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Throws tr = new Throws ();
		tr.parent = new_parent;

		tr.error_domain_name = error_domain_name;
		tr.error_domain = error_domain;

		foreach (Block element in content) {
			Block copy = element.copy (tr) as Block;
			tr.content.add (copy);
		}

		return tr;
	}
}

