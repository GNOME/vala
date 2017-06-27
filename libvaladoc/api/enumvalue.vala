/* enumvalue.vala
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


using Valadoc.Content;

/**
 * Represents an enum member.
 */
public class Valadoc.Api.EnumValue: Symbol {
	private SourceComment? source_comment;
	private string? cname;

	public Content.Run default_value {
		get;
		set;
	}

	/**
	 * Specifies whether the parameter has a default value
	 */
	public bool has_default_value {
		get {
			return default_value != null;
		}
	}

	public EnumValue (Enum parent, SourceFile file, string name, SourceComment? comment, string? cname, void* data) {
		base (parent, file, name, parent.accessibility, data);

		this.source_comment = comment;
		this.cname = cname;
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void parse_comments (Settings settings, DocumentationParser parser) {
		if (documentation != null) {
			return ;
		}

		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.parse_comments (settings, parser);
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void check_comments (Settings settings, DocumentationParser parser) {
		if (documentation != null) {
			parser.check (this, documentation);
		}

		base.check_comments (settings, parser);
	}

	/**
	 * Returns the name of this enum value as it is used in C.
	 */
	public string get_cname () {
		return cname;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type { get { return NodeType.ENUM_VALUE; } }

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_enum_value (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var builder = new SignatureBuilder ()
				.append_symbol (this);

		if (has_default_value) {
			builder.append ("=");
			builder.append_content (default_value);
		}

		return builder.get ();
	}
}

