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



public enum Valadoc.TextVerticalPosition {
	TOP,
	MIDDLE,
	BOTTOM
}

public enum Valadoc.TextPosition {
	LEFT,
	RIGHT,
	CENTER
}

public enum Valadoc.ImageDocElementPosition {
	NEUTRAL,
	MIDDLE,
	RIGHT,
	LEFT
}

public enum Valadoc.Language {
	GENIE,
	VALA,
	C
}

public enum Valadoc.ListType {
	UNSORTED,
	SORTED
}



public interface Valadoc.Documented : Object {
	public abstract string? get_filename ();
}


public abstract class Valadoc.DocElement : Object {
	public abstract bool write (void* res, int max, int index);
}

public abstract class Valadoc.Taglet : DocElement {
}

public abstract class Valadoc.InlineTaglet : Taglet {
	public abstract bool parse (Settings settings, Tree tree, Documented self, string content, ref ErrorLevel errlvl, out string? errmsg);
	public abstract string to_string ();
}

public abstract class Valadoc.CodeConstantDocElement : Valadoc.DocElement {
	public abstract bool parse (string constant);
}

public abstract class Valadoc.MainTaglet : Taglet {
	// remove
	protected string? get_data_type (DocumentedElement me) {
		if (me is Valadoc.Class)
			return "class";
		if (me is Valadoc.Delegate)
			return "delegate";
		if (me is Valadoc.Interface)
			return "interface";
		if (me is Valadoc.Method)
			return "method";
		if (me is Valadoc.Property)
			return "property";
		if (me is Valadoc.Signal)
			return "signal";
		if (me is Valadoc.Enum)
			return "enum";
		if (me is Valadoc.EnumValue)
			return "enum-value";
		if (me is Valadoc.ErrorDomain)
			return "errordomain";
		if (me is Valadoc.ErrorCode)
			return "error-code";
		if (me is Valadoc.Field)
			return "field";
		if (me is Valadoc.Constant)
			return "constant";
		if (me is Valadoc.Namespace)
			return "namespace";

		return null;
	}

	public virtual int order { get { return 0; } }
	public abstract bool parse (Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, ref ErrorLevel errlvl, out string errmsg);
	public abstract bool write_block_start (void* res);
	public abstract bool write_block_end (void* res);
}



public abstract class Valadoc.StringTaglet : Taglet {
	public string content {
		protected set; get;
	}

	public abstract bool parse (string content);
}

public abstract class Valadoc.HeadlineDocElement : DocElement {
	public abstract bool parse (owned string title, int lvl);
}

public abstract class Valadoc.ImageDocElement : DocElement {
	public abstract bool parse (Settings settings, Documented pos, owned string path, owned string alt);
}

public abstract class Valadoc.LinkDocElement : DocElement {
	public abstract bool parse (Settings settings, Tree tree, Documented pos, owned string link, owned string desc);
}

public abstract class Valadoc.SourceCodeDocElement : DocElement {
	public abstract bool parse (owned string src, Language lang);
}

public abstract class Valadoc.ListEntryDocElement : DocElement {
	public abstract bool parse (ListType type, long lvl, Gee.ArrayList<DocElement> content);
}

public abstract class Valadoc.ListDocElement : DocElement {
	public abstract bool parse (ListType type, Gee.ArrayList<ListEntryDocElement> entries);
}

public abstract class Valadoc.NotificationDocElement : DocElement {
	public abstract bool parse (Gee.ArrayList<DocElement> content);
}


public abstract class Valadoc.HighlightedDocElement : DocElement {
	public abstract bool parse (Gee.ArrayList<DocElement> content);
}

public abstract class Valadoc.ItalicDocElement : HighlightedDocElement {
}

public abstract class Valadoc.BoldDocElement : HighlightedDocElement {
}

public abstract class Valadoc.UnderlinedDocElement : HighlightedDocElement {
}



public abstract class Valadoc.ContentPositionDocElement : DocElement {
	public abstract bool parse (Gee.ArrayList<DocElement> content);
}

public abstract class Valadoc.CenterDocElement : ContentPositionDocElement {
}

public abstract class Valadoc.RightAlignedDocElement : ContentPositionDocElement {
}

public abstract class Valadoc.TableCellDocElement : DocElement {
	public abstract void parse (TextPosition pos, TextVerticalPosition hpos, int size, int dsize, Gee.ArrayList<DocElement> content);
}

public abstract class Valadoc.TableDocElement : DocElement {
	public abstract void parse (Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> cells);
}




public class Valadoc.DocumentationTree : Object {
	private Gee.ArrayList<DocElement> description = new Gee.ArrayList<DocElement> ();
	private Gee.ArrayList<DocElement> brief = new Gee.ArrayList<DocElement> ();
	private Gee.HashMap<Type, Gee.ArrayList<MainTaglet> > taglets
		= new Gee.HashMap<Type, Gee.ArrayList<MainTaglet> > ();

	public void add_taglet (MainTaglet taglet) {
		if ( this.taglets.contains (taglet.get_type())) {
			ArrayList<MainTaglet> lst = this.taglets.get(taglet.get_type());
			lst.add(taglet);
		}
		else {
			ArrayList<MainTaglet> lst = new ArrayList<MainTaglet> ();
			this.taglets.set(taglet.get_type(), lst);
			lst.add(taglet);
		}
	}

	public void add_taglets (Collection<MainTaglet> taglets) {
		foreach (MainTaglet tag in taglets) {
			this.add_taglet(tag);
		}
	}

	public Gee.ReadOnlyCollection<DocElement> get_brief ( ) {
		return new Gee.ReadOnlyCollection<DocElement> ((this.brief == null)? new Gee.ArrayList<DocElement>() : this.brief);
	}

	public void add_brief (Gee.ArrayList<DocElement> content) {
		this.brief = content;
	}

	public Gee.ReadOnlyCollection<DocElement> get_description () {
		return new Gee.ReadOnlyCollection<DocElement> ((this.description == null)? new Gee.ArrayList<DocElement>() : this.description);
	}

	public void add_description (Gee.ArrayList<DocElement> content) {
		this.description = content;
	}

	private static Gee.ArrayList< Gee.ArrayList<MainTaglet> > sort_tag_collection (Gee.Collection< Gee.ArrayList<MainTaglet> > lst) {
		Gee.ArrayList< Gee.ArrayList<MainTaglet> > slst
			= new Gee.ArrayList< Gee.ArrayList<MainTaglet> > ();

		foreach (Gee.ArrayList<MainTaglet> entry in lst) {
			slst.add (entry);
		}

		//<bublesort>
		int count = slst.size;
		if (count <= 0)
			return slst;

		for (int i = 0; i < count; i++) {
			for (int j = count-1; j>i; j--) {
				if (slst.get(j).get(0).order < slst.get(j-1).get(0).order) {
					Gee.ArrayList<MainTaglet> tmp1 = slst.get(j-1);
					Gee.ArrayList<MainTaglet> tmp2 = slst.get(j);

					slst.remove_at (j);
					slst.insert (j, tmp1);
					slst.remove_at (j-1);
					slst.insert (j-1, tmp2);
				}
			}
		}
		//</bublesort>
		return slst;
	}

	public bool write_brief (void* res) {
		if (this.brief == null)
			return true;

		int _max = this.brief.size;
		int _index = 0;

		foreach (DocElement element in this.brief) {
			element.write (res, _max, _index);
			_index++;
		}
		return true;
	}

	public bool write_content (void* res) {
		if (this.description == null)
			return true;

		int max = this.description.size;
		int i = 0;
		bool tmp;

		foreach (DocElement tag in this.description) {
			tmp = tag.write (res, max, i);
			if (tmp == false)
				return false;

			i++;
		}

		Gee.Collection< Gee.ArrayList<MainTaglet> > lst = this.taglets.get_values ( );
		Gee.ArrayList< Gee.ArrayList<MainTaglet> > alst = sort_tag_collection ( lst );

		foreach (Gee.ArrayList<MainTaglet> tags in alst) {
			MainTaglet ftag = tags.get (0);
			max = tags.size;
			i = 0;

			tmp = ftag.write_block_start (res);
			if (tmp == false)
				return false;

			foreach (MainTaglet tag in tags) {
				tmp = tag.write (res, max, i);
				if ( tmp == false )
					return false;

				i++;
			}

			tmp = ftag.write_block_end (res);
			if (tmp == false)
				return false;
		}
		return true;
	}
}

