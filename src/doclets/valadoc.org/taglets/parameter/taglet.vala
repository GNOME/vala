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


using GLib;
using Gee;


public class Valadoc.ValdocOrg.ParameterTaglet : Valadoc.MainTaglet {
	public override int order { get { return 100; } }
	private Gee.Collection<DocElement> content;
	private string paramname;

	private static bool check_parameter_name (Valadoc.ParameterListHandler me, string name) {
		if (name == "") {
			return false;
		}

		foreach (Valadoc.FormalParameter param in me.get_parameter_list ()) {
			if (param.name == name) {
				return true;
			}
		}
		return false;
	}

	public override bool write (void* ptr, int max, int index) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.printf (" @param %s \n", this.paramname);

		int _max = this.content.size;
		int _index = 0;

		foreach (DocElement tag in this.content) {
			tag.write ( ptr, _max, _index );
			_index++;
		}

		file.puts ( "\n" );
		return true;
	}

	public override bool write_block_start (void* ptr) {
		return true;
	}

	public override bool write_block_end (void* ptr) {
		return true;
	}

	public override bool parse (Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, ref ErrorLevel errlvl, out string errmsg) {
		if (me is Valadoc.ParameterListHandler == false) {
			errmsg = "Tag @param cannot be used in this context";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		if (content.size == 0) {
			errmsg = "Parameter name was expected";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		Gee.ArrayList<DocElement> contentlst = new Gee.ArrayList<DocElement> ();
		foreach (DocElement element in content) {
			contentlst.add (element);
		}

		DocElement tag = contentlst.get(0);
		if (tag is StringTaglet == false) {
			errmsg = "Parameter name was expected";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		string str = ((StringTaglet)tag).content;
		weak string lposa =  str.chr (-1, '\n');
		weak string lposb =  str.chr (-1, ' ');
		weak string lpos;

		long lposaoffset = (lposa == null)? long.MAX : str.pointer_to_offset (lposa);
		long lposboffset = (lposb == null)? long.MAX : str.pointer_to_offset (lposb);

		if (lposaoffset < lposboffset) {
			lpos = lposa;
		}
		else {
			lpos = lposb;
		}

		if (lpos == null) {
			this.paramname = str.strip ();
			((StringTaglet)tag).content = "";
		}
		else {
			int namepos = (int)str.pointer_to_offset (lpos);
			this.paramname = str.ndup (namepos).strip ();
			((StringTaglet)tag).content = lpos.ndup (lpos.size ()).chomp ();
		}

		bool tmp = this.check_parameter_name ( (Valadoc.ParameterListHandler)me, this.paramname);
		if ( tmp == false ) {
			errmsg = "Parameter is not available";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		this.content = contentlst;
		return true;
	}
}


[ModuleInit]
public GLib.Type register_plugin (Gee.HashMap<string, Type> taglets) {
	GLib.Type type = typeof (Valadoc.ValdocOrg.ParameterTaglet );
	taglets.set ("param", type);
	return type;
}

