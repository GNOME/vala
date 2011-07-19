/* namespace.vala
 *
 * Copyright (C) 2008-2011  Florian Brosch
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
using Valadoc.Content;


/**
 * Represents a namespace declaration.
 */
public class Valadoc.Api.Namespace : Symbol {
	private SourceComment? source_comment;

	public Namespace (Api.Node parent, SourceFile file, string? name, SourceComment? comment, void* data) {
		base (parent, file, name, SymbolAccessibility.PUBLIC, data);

		this.source_comment = comment;
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void process_comments (Settings settings, DocumentationParser parser) {
		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.process_comments (settings, parser);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword (get_accessibility_modifier ())
			.append_keyword ("namespace")
			.append_symbol (this)
			.get ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type { get { return NodeType.NAMESPACE; } }

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_namespace (this);
	}
}

