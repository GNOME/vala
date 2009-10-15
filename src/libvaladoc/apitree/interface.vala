/*
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

using Gee;


public class Valadoc.Interface : Api.TypeSymbolNode, SignalHandler, PropertyHandler, FieldHandler, ConstantHandler, TemplateParameterListHandler, MethodHandler, DelegateHandler, EnumHandler, StructHandler, ClassHandler {
	public Interface (Vala.Interface symbol, Api.Node parent) {
		base (symbol, parent);
		this.vinterface = symbol;
	}

	private ArrayList<Interface> interfaces = new ArrayList<Interface> ();

	public Collection<Interface> get_implemented_interface_list () {
		return this.interfaces;
	}

	public string? get_cname () {
		return this.vinterface.get_cname ();
	}

	protected Class? base_type {
		private set;
		get;
	}

	private Vala.Interface vinterface;

	public void visit (Doclet doclet) {
		doclet.visit_interface (this);
	}

	public override Api.NodeType node_type { get { return Api.NodeType.INTERFACE; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_interface (this, ptr);
	}

	private void set_prerequisites (Tree root, Vala.Collection<Vala.DataType> lst) {
		if (this.interfaces.size != 0) {
			return;
		}

		foreach (Vala.DataType vtyperef in lst) {
			Api.Item? element = root.search_vala_symbol (vtyperef.data_type);
			if (element is Class) {
				this.base_type = (Class)element;
			} else {
				this.interfaces.add ((Interface)element);
			}
		}
	}

	protected override void resolve_type_references (Tree root) {
		var lst = this.vinterface.get_prerequisites ();
		this.set_prerequisites (root, lst);

		base.resolve_type_references (root);
	}
}


