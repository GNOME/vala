/* valagtkmodule.vala
 *
 * Copyright (C) 2013  Jürg Billeter
 * Copyright (C) 2013  Luca Bruno
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
	private bool is_gtk_template (Class? cl) {
		return cl != null && gtk_widget_type != null && cl.is_subtype_of (gtk_widget_type) && cl.get_attribute ("GtkTemplate") != null;
	}

	public override void generate_class_init (Class cl) {
		base.generate_class_init (cl);

		if (!is_gtk_template (cl)) {
			return;
		}

		/* Gtk builder widget template */
		var ui = cl.get_attribute_string ("GtkTemplate", "ui");
		if (ui == null) {
			Report.error (cl.source_reference, "Empty ui file declaration for Gtk widget template");
			cl.error = true;
			return;
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_class_set_template_from_resource"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET_CLASS (klass)"));
		call.add_argument (new CCodeConstant ("\""+cl.get_attribute_string ("GtkTemplate", "ui")+"\""));
		ccode.add_expression (call);
	}

	public override void visit_field (Field f) {
		base.visit_field (f);

		var cl = current_class;
		if (!is_gtk_template (cl)) {
			return;
		}

		if (f.binding != MemberBinding.INSTANCE || f.get_attribute ("GtkChild") == null) {
			return;
		}

		push_context (class_init_context);

		/* Map ui widget to a class field */
		var gtk_name = f.get_attribute_string ("GtkChild", "name", f.name);
		var internal_child = f.get_attribute_bool ("GtkChild", "internal");

		var offset = new CCodeFunctionCall (new CCodeIdentifier ("G_STRUCT_OFFSET"));
		offset.add_argument (new CCodeIdentifier ("%sPrivate".printf (get_ccode_name (cl))));
		offset.add_argument (new CCodeIdentifier (get_ccode_name (f)));

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_class_automate_child"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET_CLASS (klass)"));
		call.add_argument (new CCodeConstant ("\"%s\"".printf (gtk_name)));
		call.add_argument (new CCodeConstant (internal_child ? "TRUE" : "FALSE"));
		call.add_argument (offset);
		ccode.add_expression (call);

		pop_context ();
	}

	/* Generate a wrapper function that swaps two parameters */
	private string generate_gtk_swap_callback (Method m) {
		var wrapper_name = "_vala_gtktemplate_callback_%s".printf (get_ccode_name (m));
		if (!add_wrapper (wrapper_name)) {
			return wrapper_name;
		}

		var function = new CCodeFunction (wrapper_name, "void");
		function.add_parameter (new CCodeParameter ("connect_object", "gpointer"));
		function.add_parameter (new CCodeParameter ("object", "gpointer"));
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);

		var call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));
		call.add_argument (new CCodeIdentifier ("object"));
		if (m.get_parameters().size > 0) {
			call.add_argument (new CCodeIdentifier ("connect_object"));
		}
		ccode.add_expression (call);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return wrapper_name;
	}

	public override void visit_method (Method m) {
		base.visit_method (m);

		var cl = current_class;
		if (!is_gtk_template (cl)) {
			return;
		}

		if (m.binding != MemberBinding.INSTANCE || m.get_attribute ("GtkCallback") == null) {
			return;
		}

		push_context (class_init_context);

		/* Map a ui callback to a class method */
		var gtk_name = m.get_attribute_string ("GtkCallback", "name", m.name);
		string callback_name;
		// This is the "swap" option of gtkbuilder/glade.
		if (!m.get_attribute_bool ("GtkCallback", "swap")) {
			/* If swap=false, the function is called with (object, data) but we want (data, object).
			 * Therefore we create a wrapper that swaps the two parameters. */
			callback_name = generate_gtk_swap_callback (m);
		} else {
			callback_name = get_ccode_name (m);
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_class_declare_callback"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET_CLASS (klass)"));
		call.add_argument (new CCodeConstant ("\"%s\"".printf (gtk_name)));
		call.add_argument (new CCodeIdentifier ("G_CALLBACK(%s)".printf (callback_name)));
		ccode.add_expression (call);

		pop_context ();
	}


	public override void generate_instance_init (Class cl) {
		if (!is_gtk_template (cl)) {
			return;
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier ("gtk_widget_init_template"));
		call.add_argument (new CCodeIdentifier ("GTK_WIDGET (self)"));
		ccode.add_expression (call);
	}
}

