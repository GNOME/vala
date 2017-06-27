/* errorcode.vala
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
 * Represents an errordomain member in the source code.
 */
public class Valadoc.Api.ErrorCode : Symbol {
	private SourceComment? source_comment;
	private string? dbus_name;
	private string? cname;

	public ErrorCode (ErrorDomain parent, SourceFile file, string name, SourceComment? comment,
					  string? cname, string? dbus_name, void* data)
	{
		base (parent, file, name, parent.accessibility, data);

		this.source_comment = comment;
		this.dbus_name = dbus_name;
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
	 * Returns the name of this class as it is used in C.
	 */
	public string get_cname () {
		return cname;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string get_dbus_name () {
		return dbus_name;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.ERROR_CODE; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_error_code (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_symbol (this)
			.get ();
	}
}

