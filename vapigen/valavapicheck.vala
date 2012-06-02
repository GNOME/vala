/* valavapicheck.vala
 *
 * Copyright (C) 2007  Mathias Hasselmann
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
 * 	Mathias Hasselmann <mathias.hasselmann@gmx.de>
 */

using GLib;

class Vala.VAPICheck : Object {
	public VAPICheck (string gidlname, CodeContext context = new CodeContext ()) {
		gidl = new SourceFile (context, SourceFileType.SOURCE, gidlname);
		metadata = new SourceFile (context, SourceFileType.SOURCE, gidlname.substring (0, gidlname.length - 5) + ".metadata");
		this.context = context;
	}

	public CodeContext context { get; private set; }
	public SourceFile gidl { get; private set; }
	public SourceFile metadata { get; private set; }

	private List<string> _scope;
	private Set<string> _symbols;

	private void parse_gidl () {
		_scope = new ArrayList<string> ();
		_symbols = new HashSet<string> (str_hash, str_equal);

		try {
			foreach (weak IdlModule module in Idl.parse_file (gidl.filename)) {
				parse_members (module.name, module.entries);
			}
		} catch (MarkupError e) {
			stderr.printf ("%s: %s\n", gidl.filename, e.message);
                }
	}

	private void add_symbol (string name, string? separator = null) {

		if (null != separator) {
			string fullname = get_scope () + separator + name;
			_symbols.add (fullname);
		} else {
			_symbols.add (name);
		}
	}

	private string get_scope () {
		return _scope[_scope.size - 1];
	}

	private void enter_scope (string name) {
		_scope.add (name);
		add_symbol (name);
	}

	private void leave_scope () {
		_scope.remove_at (_scope.size - 1);
	}

	private void parse_members (string name, GLib.List<IdlNode> members) {
		enter_scope (name);

		foreach (weak IdlNode node in members) {
			switch (node.type) {
				case IdlNodeTypeId.ENUM:
					parse_members (((IdlNodeEnum) node).gtype_name,
								   ((IdlNodeEnum) node).values);
					break;

				case IdlNodeTypeId.FUNCTION:
					parse_members (((IdlNodeFunction) node).symbol,
								   (GLib.List<IdlNode>) ((IdlNodeFunction) node).parameters);
					break;

				case IdlNodeTypeId.BOXED:
					parse_members (((IdlNodeBoxed) node).gtype_name,
								   ((IdlNodeBoxed) node).members);
					break;

				case IdlNodeTypeId.INTERFACE:
				case IdlNodeTypeId.OBJECT:
					parse_members (((IdlNodeInterface) node).gtype_name,
								   ((IdlNodeInterface) node).members);
					break;

				case IdlNodeTypeId.FIELD:
				case IdlNodeTypeId.PARAM:
					add_symbol (node.name, ".");
					break;

				case IdlNodeTypeId.PROPERTY:
				case IdlNodeTypeId.SIGNAL:
					add_symbol (node.name, "::");
					break;

				case IdlNodeTypeId.STRUCT:
					parse_members (node.name, ((IdlNodeStruct) node).members);
					break;

				case IdlNodeTypeId.VALUE:
				case IdlNodeTypeId.VFUNC:
					// Not appliable?
					break;

				default:
					warning ("TODO: %s: Implement support for type %d nodes", node.name, node.type);
					break;
			}
		}

		leave_scope ();
	}

	private int check_metadata () {
		try {
			var metafile = new IOChannel.file (metadata.filename, "r");
			string line;
			int lineno = 1;

			while (IOStatus.NORMAL == metafile.read_line (out line, null, null)) {
				var tokens = line.split (" ", 2);
				var symbol = tokens[0];

				if (symbol.length > 0 && !_symbols.contains (symbol)) {
					var src = new SourceReference (metadata, SourceLocation (null, lineno, 1), SourceLocation (null, lineno, (int)symbol.length));
					Report.error (src, "Symbol `%s' not found".printf (symbol));
				}

				lineno += 1;
			}

			return 0;
		} catch (Error error) {
			Report.error (null, "%s: %s".printf (metadata.filename, error.message));
			return 1;
		}
	}

	public int run () {
		if (!FileUtils.test (gidl.filename, FileTest.IS_REGULAR)) {
			Report.error (null, "%s not found".printf (gidl.filename));
			return 2;
		}

		if (!FileUtils.test (metadata.filename, FileTest.IS_REGULAR)) {
			Report.error (null, "%s not found".printf (metadata.filename));
			return 2;
		}

		parse_gidl ();

		return check_metadata ();
	}

	static int main (string[] args) {
		if (2 != args.length || !args[1].has_suffix (".gidl")) {
			stdout.printf ("Usage: %s library.gidl\n",
				       Path.get_basename (args[0]));
			return 2;
		}

		var vapicheck = new VAPICheck (args[1]);
		return vapicheck.run ();
	}
}
