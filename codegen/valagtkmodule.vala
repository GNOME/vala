/* valagtkmodule.vala
 *
 * Copyright (C) 2013  Jürg Billeter
 * Copyright (C) 2013-2014  Luca Bruno
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Luca Bruno <lucabru@src.gnome.org>
 */


public class Vala.GtkModule : GSignalModule {
	/* C type-func name to Vala class mapping */
	private HashMap<string, Class> type_id_to_vala_map = null;
	/* C class name to Vala class mapping */
	private HashMap<string, Class> cclass_to_vala_map = null;
	/* GResource name to real file name mapping */
	private HashMap<string, string> gresource_to_file_map = null;
	/* GtkBuilder xml handler to Vala signal mapping */
	private HashMap<string, Signal> current_handler_to_signal_map = new HashMap<string, Signal>(str_hash, str_equal);
	/* GtkBuilder xml child to Vala class mapping */
	private HashMap<string, Class> current_child_to_class_map = new HashMap<string, Class>(str_hash, str_equal);
	/* Required custom application-specific gtype classes to be ref'd before initializing the template */
	private List<Class> current_required_app_classes = new ArrayList<Class>();

	private void ensure_type_id_to_vala_map () {
		// map C type-func name of gtypeinstance classes to Vala classes
		if (type_id_to_vala_map != null) {
			return;
		}
		type_id_to_vala_map = new HashMap<string, Class>(str_hash, str_equal);
		recurse_type_id_to_vala_map (context.root);
	}

	private void recurse_type_id_to_vala_map (Namespace ns) {
		foreach (var cl in ns.get_classes()) {
			if (!cl.is_compact) {
				var type_id = get_ccode_type_id (cl);
				if (type_id == null)
					continue;

				var i = type_id.index_of_char ('(');
				if (i > 0) {
					type_id = type_id.substring (0, i - 1).strip ();
				} else {
					type_id = type_id.strip ();
				}
				type_id_to_vala_map.set (type_id, cl);
			}
		}
		foreach (var inner in ns.get_namespaces()) {
			recurse_type_id_to_vala_map (inner);
		}
	}

	private void ensure_cclass_to_vala_map () {
		// map C name of gtypeinstance classes to Vala classes
		if (cclass_to_vala_map != null) {
			return;
		}
		cclass_to_vala_map = new HashMap<string, Class>(str_hash, str_equal);
		recurse_cclass_to_vala_map (context.root);
	}

	private void recurse_cclass_to_vala_map (Namespace ns) {
		foreach (var cl in ns.get_classes()) {
			if (!cl.is_compact) {
				cclass_to_vala_map.set (get_ccode_name (cl), cl);
			}
		}
		foreach (var inner in ns.get_namespaces()) {
			recurse_cclass_to_vala_map (inner);
		}
	}

	private void ensure_gresource_to_file_map () {
		// map gresource paths to real file names
		if (gresource_to_file_map != null) {
			return;
		}
		gresource_to_file_map = new HashMap<string, string>(str_hash, str_equal);
		foreach (var gresource in context.gresources) {
			if (!FileUtils.test (gresource, FileTest.EXISTS)) {
				Report.error (null, "GResources file `%s' does not exist".printf (gresource));
				continue;
			}

			MarkupReader reader = new MarkupReader (gresource);

			int state = 0;
			string prefix = null;
			string alias = null;

			MarkupTokenType current_token = reader.read_token (null, null);
			while (current_token != MarkupTokenType.EOF) {
				if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "gresource") {
					prefix = reader.get_attribute ("prefix");
				} else if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "file") {
					alias = reader.get_attribute ("alias");
					state = 1;
				} else if (state == 1 && current_token == MarkupTokenType.TEXT) {
					var name = reader.content;
					var filename = context.get_gresource_path (gresource, name);
					if (alias != null) {
						gresource_to_file_map.set (Path.build_filename (prefix, alias), filename);
					}
					gresource_to_file_map.set (Path.build_filename (prefix, name), filename);
					state = 0;
				}
				current_token = reader.read_token (null, null);
			}
		}
	}

	private void process_current_ui_resource (string ui_resource, CodeNode node) {
		/* Scan a single gtkbuilder file for signal handlers in <object> elements,
		   and save an handler string -> Vala.Signal mapping for each of them */
		ensure_type_id_to_vala_map ();
		ensure_cclass_to_vala_map();
		ensure_gresource_to_file_map();

		current_handler_to_signal_map = null;
		current_child_to_class_map = null;
		var ui_file = gresource_to_file_map.get (ui_resource);
		if (ui_file == null || !FileUtils.test (ui_file, FileTest.EXISTS)) {
			node.error = true;
			Report.error (node.source_reference, "UI resource not found: `%s'. Please make sure to specify the proper GResources xml files with --gresources and alternative search locations with --gresourcesdir.".printf (ui_resource));
			return;
		}
		current_handler_to_signal_map = new HashMap<string, Signal>(str_hash, str_equal);
		current_child_to_class_map = new HashMap<string, Class>(str_hash, str_equal);

		MarkupReader reader = new MarkupReader (ui_file);
		Class current_class = null;

		bool template_tag_found = false;
		MarkupTokenType current_token = reader.read_token (null, null);
		while (current_token != MarkupTokenType.EOF) {
			unowned string current_name = reader.name;
			if (current_token == MarkupTokenType.START_ELEMENT && (current_name == "object" || current_name == "template")) {
				current_class = null;

				if (current_name == "object") {
					var type_id = reader.get_attribute ("type-func");
					if (type_id != null) {
						current_class = type_id_to_vala_map.get (type_id);
					}
				} else if (current_name == "template") {
					template_tag_found = true;
				}

				if (current_class == null) {
					var class_name = reader.get_attribute ("class");
					if (class_name == null) {
						Report.error (node.source_reference, "Invalid %s in ui file `%s'".printf (current_name, ui_file));
						current_token = reader.read_token (null, null);
						continue;
					}
					current_class = cclass_to_vala_map.get (class_name);
				}

				if (current_class != null) {
					var child_name = reader.get_attribute ("id");
					if (child_name != null) {
						current_child_to_class_map.set (child_name, current_class);
					}
				}
			} else if (current_class != null && current_token == MarkupTokenType.START_ELEMENT && current_name == "signal") {
				var signal_name = reader.get_attribute ("name");
				var handler_name = reader.get_attribute ("handler");

				if (current_class != null) {
					if (signal_name == null || handler_name == null) {
						Report.error (node.source_reference, "Invalid signal in ui file `%s'".printf (ui_file));
						current_token = reader.read_token (null, null);
						continue;
					}
					var sep_idx = signal_name.index_of ("::");
					if (sep_idx >= 0) {
						// detailed signal, we don't care about the detail
						signal_name = signal_name.substring (0, sep_idx);
					}

					var sig = SemanticAnalyzer.symbol_lookup_inherited (current_class, signal_name.replace ("-", "_")) as Signal;
					if (sig != null) {
						current_handler_to_signal_map.set (handler_name, sig);
					}
				}
			}
			current_token = reader.read_token (null, null);
		}

		if (!template_tag_found) {
			Report.error (node.source_reference, "ui resource `%s' does not describe a valid composite template".printf (ui_resource));
		}
	}

	private bool is_gtk_template (Class cl) {
		var attr = cl.get_attribute ("GtkTemplate");
		if (attr != null) {
			if (gtk_widget_type == null || !cl.is_subtype_of (gtk_widget_type)) {
				if (!cl.error) {
					Report.error (attr.source_reference, "subclassing Gtk.Widget is required for using Gtk templates");
					cl.error = true;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public override void generate_class_init (Class cl) {
		base.generate_class_init (cl);

		if (cl.error || !is_gtk_template (cl)) {
			return;
		}

		/* Gtk builder widget template */
		var ui = cl.get_attribute_string ("GtkTemplate", "ui");
		if (ui == null) {
			Report.error (cl.source_reference, "empty ui resource declaration for Gtk widget template");
			cl.error = true;
			return;
		}

		process_current_ui_resource (ui, cl);

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_class_set_template_from_resource"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET_CLASS (klass)"));
		call.add_argument (new CCodeConstant ("\"%s\"".printf (ui)));
		ccode.add_expression (call);

		current_required_app_classes.clear ();
	}

	public override void visit_property (Property prop) {
		if (prop.get_attribute ("GtkChild") != null && prop.field == null) {
			Report.error (prop.source_reference, "[GtkChild] is only allowed on automatic properties");
		}

		base.visit_property (prop);
	}

	public override void visit_field (Field f) {
		base.visit_field (f);

		var cl = current_class;
		if (cl == null || cl.error) {
			return;
		}

		if (f.binding != MemberBinding.INSTANCE || f.get_attribute ("GtkChild") == null) {
			return;
		}

		/* If the field has a [GtkChild] attribute but its class doesn'thave a
			 [GtkTemplate] attribute, we throw an error */
		if (!is_gtk_template (cl)) {
			Report.error (f.source_reference, "[GtkChild] is only allowed in classes with a [GtkTemplate] attribute");
			return;
		}

		push_context (class_init_context);

		/* Map ui widget to a class field */
		var gtk_name = f.get_attribute_string ("GtkChild", "name", f.name);
		var child_class = current_child_to_class_map.get (gtk_name);
		if (child_class == null) {
			Report.error (f.source_reference, "could not find child `%s'".printf (gtk_name));
			return;
		}

		/* We allow Gtk child to have stricter type than class field */
		unowned Class? field_class = f.variable_type.type_symbol as Class;
		if (field_class == null || !child_class.is_subtype_of (field_class)) {
			Report.error (f.source_reference, "cannot convert from Gtk child type `%s' to `%s'".printf (child_class.get_full_name(), field_class.get_full_name()));
			return;
		}

		var internal_child = f.get_attribute_bool ("GtkChild", "internal");

		CCodeExpression offset;
		if (f.is_private_symbol ()) {
			// new glib api, we add the private struct offset to get the final field offset out of the instance
			var private_field_offset = new CCodeFunctionCall (new CCodeIdentifier ("G_STRUCT_OFFSET"));
			private_field_offset.add_argument (new CCodeIdentifier ("%sPrivate".printf (get_ccode_name (cl))));
			private_field_offset.add_argument (new CCodeIdentifier (get_ccode_name (f)));
			offset = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("%s_private_offset".printf (get_ccode_name (cl))), private_field_offset);
		} else {
			var offset_call = new CCodeFunctionCall (new CCodeIdentifier ("G_STRUCT_OFFSET"));
			offset_call.add_argument (new CCodeIdentifier (get_ccode_name (cl)));
			offset_call.add_argument (new CCodeIdentifier (get_ccode_name (f)));
			offset = offset_call;
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_class_bind_template_child_full"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET_CLASS (klass)"));
		call.add_argument (new CCodeConstant ("\"%s\"".printf (gtk_name)));
		call.add_argument (new CCodeConstant (internal_child ? "TRUE" : "FALSE"));
		call.add_argument (offset);
		ccode.add_expression (call);

		pop_context ();

		if (!field_class.external && !field_class.external_package) {
			current_required_app_classes.add (field_class);
		}
	}

	public override void visit_method (Method m) {
		base.visit_method (m);

		var cl = current_class;
		if (cl == null || cl.error || !is_gtk_template (cl)) {
			return;
		}

		if (m.binding != MemberBinding.INSTANCE || m.get_attribute ("GtkCallback") == null) {
			return;
		}

		/* Handler name as defined in the gtkbuilder xml */
		var handler_name = m.get_attribute_string ("GtkCallback", "name", m.name);
		var sig = current_handler_to_signal_map.get (handler_name);
		if (sig == null) {
			Report.error (m.source_reference, "could not find signal for handler `%s'".printf (handler_name));
			return;
		}

		push_context (class_init_context);

		if (sig != null) {
			sig.check (context);
			var method_type = new MethodType (m);
			var signal_type = new SignalType (sig);
			var delegate_type = signal_type.get_handler_type ();
			if (!method_type.compatible (delegate_type)) {
				Report.error (m.source_reference, "method `%s' is incompatible with signal `%s', expected `%s'".printf (method_type.to_string (), delegate_type.to_string (), delegate_type.to_prototype_string (m.name)));
			} else {
				var wrapper = generate_delegate_wrapper (m, signal_type.get_handler_type (), m);

				var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_class_bind_template_callback_full"));
				call.add_argument (new CCodeIdentifier ("GTK_WIDGET_CLASS (klass)"));
				call.add_argument (new CCodeConstant ("\"%s\"".printf (handler_name)));
				call.add_argument (new CCodeIdentifier ("G_CALLBACK(%s)".printf (wrapper)));
				ccode.add_expression (call);
			}
		}

		pop_context ();
	}


	public override void end_instance_init (Class cl) {
		if (cl == null || cl.error || !is_gtk_template (cl)) {
			return;
		}

		foreach (var req in current_required_app_classes) {
			/* ensure custom application widgets are initialized */
			var call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_ensure"));
			call.add_argument (get_type_id_expression (SemanticAnalyzer.get_data_type_for_symbol (req)));
			ccode.add_expression (call);
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_init_template"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET (self)"));
		ccode.add_expression (call);
	}
}

