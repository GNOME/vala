

using Graphviz;
using GLib;
using Gee;



namespace Valadoc.Diagrams {
	private static inline string get_diagram_node_name ( DataType type ) {
		string name = "";
		if ( type.nspace.full_name() != null ) {
			name = type.nspace.full_name() + ".";
		}
		return name + type.name;
	}

	public static void write_struct_diagram ( Struct stru, string path ) {
		string[] params2 = new string[5];
		params2[0] = "";
		params2[1] = "-T";
		params2[2] = "png";
		params2[3] = "-o";
		params2[4] = path;

		Graphviz.Context cntxt = Context.context( );
		cntxt.parse_args ( params2 );

		Graphviz.Graph g = Graph.open ( "g", GraphType.AGDIGRAPH );
		g.set_safe ( "rank", "", "" );

		weak Graphviz.Node me = draw_struct ( g, stru, null );
		draw_struct_parents ( stru, g, me );

		cntxt.layout_jobs ( g );
		cntxt.render_jobs ( g );
		cntxt.free_layout ( g );
	}

	private static void draw_struct_parents ( Struct stru, Graphviz.Graph g, Graphviz.Node me ) {
		Gee.Collection<DataType> parentlst = stru.get_parent_types ( );

		foreach ( DataType type in parentlst ) {
			weak Graphviz.Node stru = draw_struct ( g, (Struct)type, me );
			draw_struct_parents ( (Struct)type, g, stru );
		}
	}

	public static void write_interface_diagram ( Interface iface, string path ) {
		string[] params2 = new string[5];
		params2[0] = "";
		params2[1] = "-T";
		params2[2] = "png";
		params2[3] = "-o";
		params2[4] = path;

		Graphviz.Context cntxt = Context.context( );
		cntxt.parse_args ( params2 );

		Graphviz.Graph g = Graph.open ( "g", GraphType.AGDIGRAPH );
		g.set_safe ( "rank", "", "" );

		weak Graphviz.Node me = draw_interface ( g, iface, null );
		draw_interface_parents ( iface, g, me );

		cntxt.layout_jobs ( g );
		cntxt.render_jobs ( g );
		cntxt.free_layout ( g );
	}

	private static void draw_interface_parents ( Interface iface, Graphviz.Graph g, Graphviz.Node me ) {
		Gee.Collection<DataType> parentlst = iface.get_parent_types ( );

		foreach ( DataType type in parentlst ) {
			if ( type is Interface ) {
				draw_interface ( g, (Interface)type, me );
			}
			else {
				weak Graphviz.Node cl = draw_class ( g, (Class)type, me );
				draw_class_parents ( (Class)type, g, cl );
			}
		}
	}

	public static void write_class_diagram ( Class cl, string path ) {
		string[] params2 = new string[5];
		params2[0] = "";
		params2[1] = "-T";
		params2[2] = "png";
		params2[3] = "-o";
		params2[4] = path;

		Graphviz.Context cntxt = Context.context( );
		cntxt.parse_args ( params2 );

		Graphviz.Graph g = Graph.open ( "g", GraphType.AGDIGRAPH );
		g.set_safe ( "rank", "", "" );

		weak Graphviz.Node me = draw_class ( g, cl, null );
		draw_class_parents ( cl, g, me );

		cntxt.layout_jobs ( g );
		cntxt.render_jobs ( g );
		cntxt.free_layout ( g );
	}

	private static weak Graphviz.Node draw_struct ( Graph g, Struct stru, Graphviz.Node? parent ) {
		string name = get_diagram_node_name ( stru );
		weak Graphviz.Node? node = g.find_node ( name );
		if ( node == null ) {
			node = g.node ( name );
			node.set_safe ( "shape", "box", "" );
			node.set_safe ( "fontname", "Times", "" );
		}

		if ( parent != null ) {
			weak Edge edge = g.edge ( node, parent );
			edge.set_safe ( "dir", "back", "" );
		}

		return node;
	}

	private static weak Graphviz.Node draw_interface ( Graph g, Interface iface, Graphviz.Node? parent ) {
		string name = get_diagram_node_name ( iface );
		weak Graphviz.Node? node = g.find_node ( name );
		if ( node == null ) {
			node = g.node ( name );
			node.set_safe ( "shape", "box", "" );
			node.set_safe ( "fontname", "Times", "" );
		}

		if ( parent != null ) {
			weak Edge edge = g.edge ( node, parent );
			edge.set_safe ( "dir", "back", "" );
		}

		return node;
	}

	private static weak Graphviz.Node draw_class ( Graph g, Class cl, Graphviz.Node? parent ) {
		string name = get_diagram_node_name ( cl );
		weak Graphviz.Node? node = g.find_node ( name );
		if ( node == null ) {
			node = g.node ( name );
			node.set_safe ( "style", "bold", "" );
			node.set_safe ( "shape", "box", "" );

			if ( cl.is_abstract )
				node.set_safe ( "fontname", "Times-Italic", "" );
			else
				node.set_safe ( "fontname", "Times", "" );
		}

		if ( parent != null ) {
			weak Edge edge = g.edge ( node, parent );
			edge.set_safe ( "dir", "back", "" );
		}

		return node;
	}

	private static void draw_class_parents ( Class cl, Graphviz.Graph g, Graphviz.Node me ) {
		Gee.Collection<DataType> parents = cl.get_parent_types ( );

		foreach ( DataType type in parents ) {
			if ( type is Interface ) {
				draw_interface ( g, (Valadoc.Interface)type, me );
			}
			else if ( type is Class ) {
				weak Graphviz.Node node = draw_class ( g, (Valadoc.Class)type, me );
				draw_class_parents ( ((Class)type), g, node );
			}
		}
	}
}


