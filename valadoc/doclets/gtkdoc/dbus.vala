/* doclet.vala
 *
 * Copyright (C) 2010 Luca Bruno
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
 * 	Luca Bruno <lethalman88@gmail.com>
 */

using Valadoc;
using Valadoc.Api;
using Valadoc.Content;

namespace Gtkdoc.DBus {
	public class Parameter {
		public enum Direction {
			NONE,
			IN,
			OUT;

			public unowned string to_string () {
				switch (this) {
				case NONE:
					return "";
				case IN:
					return "in";
				case OUT:
					return "out";
				default:
					assert_not_reached ();
				}
			}
		}

		public string name;
		public string signature;
		public Direction direction;

		public Parameter (string name, string signature, Direction direction = Direction.NONE) {
			this.name = name;
			this.signature = signature;
			this.direction = direction;
		}

		public string to_string () {
			if (direction == Direction.NONE) {
				return """<parameter><type>'%s'</type> %s</parameter>""".printf (signature, name);
			} else {
				return """<parameter>%s <type>'%s'</type> %s</parameter>""".printf (direction.to_string(),
																					signature,
																					name);
			}
		}
	}

	public class Member {
		public string name;
		public Vala.List<Parameter> parameters = new Vala.ArrayList<Parameter>();
		public GComment comment;

		internal DBus.Interface iface;

		public Member (string name) {
			this.name = name;
		}

		public void add_parameter (Parameter parameter) {
			parameters.add (parameter);
		}

		public string get_docbook_id () {
			return to_docbook_id (name);
		}

		public string to_string (int indent, bool link) {
			var builder = new StringBuilder ();

			if (link) {
				builder.append_printf ("""
<link linkend="%s-%s">%s</link>%s(""",
									   iface.get_docbook_id (),
									   get_docbook_id (),
									   name,
									   string.nfill (indent-name.length, ' '));
			} else {
				builder.append_printf ("\n%s%s(",
									   name,
									   string.nfill (indent-name.length, ' '));
			}

			if (parameters.size > 0) {
				builder.append (parameters[0].to_string ());
			}
			for (int i=1; i < parameters.size; i++) {
				builder.append (",\n");
				builder.append (string.nfill (indent+1, ' '));
				builder.append (parameters[i].to_string ());
			}
			builder.append_c (')');
			return builder.str;
		}
	}

	public class Interface {
		public string package_name;
		public string name;
		public string purpose;
		public string description;
		public Vala.List<Member> methods = new Vala.ArrayList<Member>();
		public Vala.List<Member> signals = new Vala.ArrayList<Member>();

		public Interface (string package_name,
						  string name,
						  string purpose = "",
						  string description = "")
		{
			this.package_name = package_name;
			this.name = name;
			this.purpose = purpose;
			this.description = description;
		}

		public void add_method (Member member) {
			member.iface = this;
			methods.add (member);
		}

		public void add_signal (Member member) {
			member.iface = this;
			signals.add (member);
		}

		public string get_docbook_id () {
			return to_docbook_id (name);
		}

		public bool write (Settings settings, ErrorReporter reporter) {
			var xml_dir = Path.build_filename (settings.path, "xml");
			DirUtils.create_with_parents (xml_dir, 0777);

			var xml_file = Path.build_filename (xml_dir,
												"%s.xml".printf (to_docbook_id (name)));
			var writer = new TextWriter (xml_file, "w");
			if (!writer.open ()) {
				reporter.simple_error ("GtkDoc",
									   "unable to open '%s' for writing", writer.filename);
				return false;
			}
			writer.write_line (to_string (reporter));
			writer.close ();
			return true;
		}

		public string to_string (ErrorReporter reporter) {
			/* compute minimum indent for methods */
			var method_indent = 0;
			foreach (var method in methods) {
				method_indent = int.max (method_indent, (int)method.name.length);
			}
			method_indent += 5;

			/* compute minimum indent for signals */
			var signal_indent = 0;
			foreach (var sig in signals) {
				signal_indent = int.max (signal_indent, (int)sig.name.length);
			}
			signal_indent += 5;

			var builder = new StringBuilder ();
			var docbook_id = get_docbook_id ();

			builder.append ("<?xml version=\"1.0\"?><!DOCTYPE refentry PUBLIC \"-//OASIS//DTD DocBook XML V4.3//EN\" \"http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd\"");
			builder.append_printf ("""
[<!ENTITY %% local.common.attrib "xmlns:xi  CDATA  #FIXED 'http://www.w3.org/2003/XInclude'">]>
<refentry id="docs-%s">
<refmeta>
<refentrytitle role="top_of_page" id="docs-%s.top_of_page">%s</refentrytitle>
<manvolnum>3</manvolnum>
<refmiscinfo>
%s D-Bus API
</refmiscinfo>
</refmeta>
<refnamediv>
<refname>%s</refname>
<refpurpose>%s</refpurpose>
</refnamediv>""",
								docbook_id,
								docbook_id,
								name,
								package_name.ascii_up (),
								name,
								purpose ?? "");

			/*
			 * Methods
			 */
			if (methods.size > 0) {
				builder.append_printf ("""
<refsynopsisdiv id="docs-%s.synopsis" role="synopsis">
<title role="synopsis.title">Methods</title>
<synopsis>""", docbook_id);
				foreach (var method in methods) {
					builder.append (method.to_string (method_indent, true));
				}
				builder.append ("</synopsis></refsynopsisdiv>");
			}

			/*
			 * Signals
			 */
			if (signals.size > 0) {
				builder.append_printf ("""
<refsynopsisdiv id="docs-%s.signals" role="signal_proto">
<title role="signal_proto.title">Signals</title>
<synopsis>""", docbook_id);
				foreach (var sig in signals) {
					builder.append (sig.to_string (signal_indent, true));
				}
				builder.append ("</synopsis></refsynopsisdiv>");
			}

			/*
			 * Description
			 */
			builder.append_printf ("""
<refsect1 id="docs-%s.description" role="desc">
<title role="desc.title">Description</title>
%s
</refsect1>""", docbook_id, description);

			/*
			 * Methods details
			 */
			if (methods.size > 0) {
				builder.append_printf ("""
<refsect1 id="docs-%s.details" role="details">
<title role="details.title">Details</title>""", docbook_id);

				foreach (var method in methods) {
					builder.append_printf ("""
<refsect2 id="%s-%s" role="function">
<title>%s ()</title>
<programlisting>%s
</programlisting>
%s
</refsect2>""",
							docbook_id,
							method.get_docbook_id (),
							method.name,
							method.to_string (method_indent, false),
							method.comment != null ? method.comment.to_docbook (reporter) : "");
				}

				builder.append ("</refsect1>");
			}

			/*
			 * Signals details
			 */
			if (signals.size > 0) {
				builder.append_printf ("""
<refsect1 id="docs-%s.signal-details" role="signals">
<title role="signals.title">Signal Details</title>""", docbook_id);

				foreach (var sig in signals) {
					builder.append_printf ("""
<refsect2 id="%s-%s" role="signal">
<title>The <literal>%s</literal> signal</title>
<programlisting>%s
</programlisting>
%s
</refsect2>""",
						docbook_id,
						sig.get_docbook_id (),
						sig.name,
						sig.to_string (signal_indent, false),
						sig.comment != null ? sig.comment.to_docbook (reporter) : "");
				}

				builder.append ("</refsect1>");
			}

			builder.append ("</refentry>");
			return builder.str;
		}
	}
}
