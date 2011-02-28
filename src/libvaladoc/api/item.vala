/* item.vala
 *
 * Copyright (C) 2008  Florian Brosch
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
using Gee;


/**
 * Represents a node in the api tree.
 */
public abstract class Valadoc.Api.Item : Object {
	private Inline _signature;

	/**
	 * The parent of this item.
	 */
	public Item parent { protected set; get; }

	internal virtual void resolve_type_references (Tree root) {
	}

	internal virtual void resolve_children (Tree root) {
	}

	internal virtual void process_comments (Settings settings, DocumentationParser parser) {
	}

	/**
	 * The signature of this item.
	 */
	public Inline signature {
		get {
			if (_signature == null) {
				_signature = build_signature ();
			}
			return _signature;
		}
	}

	protected abstract Inline build_signature ();
}

