/* apiitem.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
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
 */

using Vala;
using GLib;
using Gee;
using Valadoc.Content;

public abstract class Valadoc.Api.Item : Object {
	public Valadoc.Settings settings {
		protected get;
		set;
	}

	public Basic parent {
		protected set;
		get;
	}

	// TODO rename root
	public Tree head {
		protected set;
		get;
	}

	protected virtual void resolve_type_references () {
	}

	protected virtual void parse_comments (DocumentationParser parser) {
	}
}
