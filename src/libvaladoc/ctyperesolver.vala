/* ctyperesolver.vala
 *
 * Copyright (C) 2010 Florian Brosch
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


using Valadoc.Api;
using Gee;

public class Valadoc.CTypeResolver : Visitor {
	private Map<string, Api.Node> nodes = new HashMap<string, Api.Node> ();

	public CTypeResolver (Api.Tree tree) {
		tree.accept (this);
	}

	public Api.Node? resolve_symbol (string name) {
		return nodes.get (name);
	}

	private void register_symbol (string? name, Api.Node node) {
		if (name != null) {
			nodes.set (name, node);
		}
	}

	private string? get_parent_type_cname (Item item) {
		string parent_cname = null;
		if (item.parent is Class) {
			parent_cname = ((Class) item.parent).get_cname ();
		} else if (item.parent is Interface) {
			parent_cname = ((Interface) item.parent).get_cname ();
		} else if (item.parent is Struct) {
			parent_cname = ((Struct) item.parent).get_cname ();
		} else if (item.parent is ErrorDomain) {
			parent_cname = ((ErrorDomain) item.parent).get_cname ();
		} else if (item.parent is Api.Enum) {
			parent_cname = ((Api.Enum) item.parent).get_cname ();
		} else {
			assert (true);
		}
		return parent_cname;
	}

	public override void visit_tree (Api.Tree item) {
		item.accept_children (this);
	}

	public override void visit_package (Package item) {
		item.accept_all_children (this, false);
	}

	public override void visit_namespace (Namespace item) {
		item.accept_all_children (this, false);
	}

	public override void visit_interface (Interface item) {
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	public override void visit_class (Class item) {
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	public override void visit_struct (Struct item) {
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	public override void visit_property (Property item) {
		string parent_cname = get_parent_type_cname (item);
		if (parent_cname != null) {
			register_symbol (parent_cname+":"+item.get_cname (), item);
		}
	}

	public override void visit_field (Field item) {
		if (item is Namespace) {
			register_symbol (item.get_cname (), item);
		} else {
			string parent_cname = get_parent_type_cname (item);
			if (parent_cname != null) {
				register_symbol (parent_cname+"."+item.get_cname (), item);
			}
		}
	}

	public override void visit_constant (Constant item) {
		register_symbol (item.get_cname (), item);
	}

	public override void visit_delegate (Delegate item) {
		register_symbol (item.get_cname (), item);
	}

	public override void visit_signal (Api.Signal item) {
		string parent_cname = get_parent_type_cname (item);
		if (parent_cname != null) {
			register_symbol (parent_cname+"::"+item.get_cname (), item);
		}
	}

	public override void visit_method (Method item) {
		register_symbol (item.get_cname (), item);
	}

	public override void visit_error_domain (ErrorDomain item) {
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	public override void visit_error_code (ErrorCode item) {
		register_symbol (item.get_cname (), item);
	}

	public override void visit_enum (Api.Enum item) {
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	public override void visit_enum_value (Api.EnumValue item) {
		register_symbol (item.get_cname (), item);
	}
}


