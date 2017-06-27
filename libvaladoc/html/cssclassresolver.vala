/* globals.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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


namespace Valadoc.Html {
	public class CssClassResolver : Api.Visitor {
		private string? css_class = null;

		public string resolve (Api.Node node) {
			node.accept (this);
			return (owned) css_class;
		}

		public override void visit_package (Api.Package item) {
			css_class = "package";
		}

		public override void visit_namespace (Api.Namespace item) {
			css_class = "namespace";
		}

		public override void visit_interface (Api.Interface item) {
			css_class = "interface";
		}

		public override void visit_class (Api.Class item) {
			if (item.is_abstract) {
				css_class = "abstract_class";
			} else {
				css_class = "class";
			}
		}

		public override void visit_struct (Api.Struct item) {
			css_class = "struct";
		}

		public override void visit_property (Api.Property item) {
			if (item.is_virtual || item.is_override) {
				css_class = "virtual_property";
			} else if (item.is_abstract) {
				css_class = "abstract_property";
			} else {
				css_class = "property";
			}
		}

		public override void visit_field (Api.Field item) {
			css_class = "field";
		}

		public override void visit_constant (Api.Constant item) {
			css_class = "constant";
		}

		public override void visit_delegate (Api.Delegate item) {
			css_class = "delegate";
		}

		public override void visit_signal (Api.Signal item) {
			css_class = "signal";
		}

		public override void visit_method (Api.Method item) {
			if (item.is_static) {
				css_class = "static_method";
			} else if (item.is_abstract) {
				css_class = "abstract_method";
			} else if (item.is_virtual || item.is_override) {
				css_class = "virtual_method";
			} else if (item.is_constructor) {
				css_class = "creation_method";
			} else {
				css_class = "method";
			}
		}

		public override void visit_error_domain (Api.ErrorDomain item) {
			css_class = "errordomain";
		}

		public override void visit_error_code (Api.ErrorCode item) {
			css_class = "errorcode";
		}

		public override void visit_enum (Api.Enum item) {
			css_class = "enum";
		}

		public override void visit_enum_value (Api.EnumValue item) {
			css_class = "enumvalue";
		}
	}
}


