/* testprinter.vala
 *
 * Copyright (C) 2020  Rico Tzschichholz
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
 *  Rico Tzschichholz <ricotz@ubuntu.com>
 */

class Sink : Vala.Report {
	public override void note (Vala.SourceReference? source, string message) {
	}

	public override void depr (Vala.SourceReference? source, string message) {
	}

	public override void warn (Vala.SourceReference? source, string message) {
	}

	public override void err (Vala.SourceReference? source, string message) {
	}
}

[CCode (array_length = false, array_null_terminated = true)]
static string[] filenames;

const OptionEntry[] options = {
	{ OPTION_REMAINING, 0, 0, OptionArg.FILENAME_ARRAY, ref filenames, "Input source file", "FILE" },
	{ null }
};

int main (string[] args) {
	try {
		var opt_context = new OptionContext ();
		opt_context.add_main_entries (options, null);
		opt_context.parse (ref args);
	} catch (OptionError e) {
		return 1;
	}

	if (filenames.length != 1) {
		return 1;
	}

	string filename = filenames[0];

	var context = new Vala.CodeContext ();
	context.set_target_profile (Vala.Profile.GOBJECT);
	context.keep_going = true;
	context.report = new Sink ();

	Vala.CodeContext.push (context);

	context.add_source_filename (filename);

	var vala_parser = new Vala.Parser ();
	vala_parser.parse (context);
	//context.check ();

	unowned Vala.SourceReference src = context.get_source_file (filename).first;
	while (true) {
		{
			stdout.printf ("%s | %s | %s\n", src.begin.to_string (), src.end.to_string (), src.node.type_name);
		}
		if (src.next == null) {
			if (src != context.get_source_file (filename).last) {
				return 1;
			}
			break;
		}
		src = src.next;
	}

	Vala.CodeContext.pop ();

	return 0;
}
