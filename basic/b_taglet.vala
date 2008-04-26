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


public static delegate BasicTaglet Valadoc.TagletCreator ( Valadoc.Tree tree, Valadoc.Basic element,
																													Valadoc.ErrorReporter err, Valadoc.Settings settings );



public abstract class Valadoc.BasicTaglet : Object {
	public uint indenture_number;

	public virtual void write ( void* ptr ) {
	}
}


public class Valadoc.StringTaglet : BasicTaglet {
	public string str;

	public static Valadoc.StringTaglet create ( Valadoc.Basic element ) {
		return new Valadoc.StringTaglet ();
	}

	public void parse ( string str ) {
		this.str = str;
	}

	public override void write ( void* ptr ) {
		((GLib.FileStream)ptr).puts ( this.str );
	}
}


public abstract class Valadoc.InlineTaglet : BasicTaglet {
	public Valadoc.Basic element {
		construct set;
		get;
	}

	public Valadoc.Tree doctree {
		construct set;
		get;
	}

	public Valadoc.ErrorReporter err {
		construct set;
		get;
	}

	public virtual void parse ( string str ) {
	}
}

public abstract class Valadoc.MainTaglet : BasicTaglet {
	protected bool block_type = false;
	protected bool unique = false;

	public Valadoc.Basic element {
		construct set;
		get;
	}

	public Valadoc.Tree doctree {
		construct set;
		get;
	}

	public Valadoc.ErrorReporter err {
		construct set;
		get;
	}

	public virtual void parse ( Gee.Collection<Valadoc.BasicTaglet> lst ) {
	}

	public virtual void start_block ( void* ptr ) {
	}

	public virtual void end_block ( void* ptr ) {
	}
}

