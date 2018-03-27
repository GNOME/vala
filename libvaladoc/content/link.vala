/* link.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2014 Florian Brosch
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


public class Valadoc.Content.Link : InlineContent, Inline {
	public string url {
		set;
		get;
	}

	/**
	 * Used by importers to transform internal URLs
	 */
	public Importer.InternalIdRegistrar id_registrar {
		internal set;
		get;
	}


	internal Link () {
		base ();
	}

	public override void configure (Settings settings, ResourceLocator locator) {
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{

		// Internal gktdoc-id? (gir-importer)
		if (id_registrar != null) {
			Api.Node? node = id_registrar.map_symbol_id (url);
			if (node != null) {
				InlineContent _parent = parent as InlineContent;
				assert (_parent != null);

				SymbolLink replacement = new SymbolLink (node);
				replacement.content.add_all (content);

				replacement.check (api_root, container, file_path, reporter, settings);
				_parent.replace_node (this, replacement);
				return ;
			}


			string _url = id_registrar.map_url_id (url);
			if (_url == null) {
				string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
				reporter.simple_warning ("%s: %s[[".printf (file_path, node_segment),
										 "unknown imported internal id '%s'", url);

				InlineContent _parent = parent as InlineContent;
				assert (_parent != null);

				Run replacement = new Run (Run.Style.ITALIC);
				replacement.content.add_all (content);
				replacement.check (api_root, container, file_path, reporter, settings);

				_parent.replace_node (this, replacement);
				return ;
			}

			url = _url;
		}


		//TODO: check url
		base.check (api_root, container, file_path, reporter, settings);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_link (this);
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Link link = new Link ();
		link.id_registrar = id_registrar;
		link.parent = new_parent;
		link.url = url;

		foreach (Inline element in content) {
			Inline copy = element.copy (link) as Inline;
			link.content.add (copy);
		}

		return link;
	}
}
