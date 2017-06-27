/* tagletinheritdoc.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2012 Florian Brosch
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


using Valadoc.Content;

public class Valadoc.Taglets.InheritDoc : InlineTaglet {
	private Taglet? parent_taglet = null;

	public Api.Node? inherited {
		private set;
		get;
	}


	public override Rule? get_parser_rule (Rule run_rule) {
		return null;
	}

	private Taglet? find_parent_taglet () {
		if (_inherited == null || _inherited.documentation == null) {
			return null;
		}

		ContentElement pos;
		for (pos = this.parent; pos != null && pos is Taglet == false; pos = pos.parent);
		if (pos is Taglet) {
			return (Taglet) pos;
		}

		return null;
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		// TODO Check that the container is an override of an abstract symbol
		// Also retrieve that abstract symbol _inherited

		if (container is Api.Method) {
			_inherited = ((Api.Method) container).base_method;
		} else if (container is Api.Property) {
			_inherited = ((Api.Property) container).base_property;
		} else if (container is Api.Class && ((Api.Class) container).base_type != null) {
			_inherited = (Api.Node) ((Api.Class) container).base_type.data_type;
		} else if (container is Api.Struct && ((Api.Struct) container).base_type != null) {
			_inherited = (Api.Node) ((Api.Struct) container).base_type.data_type;
		}

		parent_taglet = find_parent_taglet ();
		if (parent_taglet == null && _inherited != null) {
			api_root.register_inheritdoc (container, this);
		}


		// TODO report error if inherited is null

		// TODO postpone check after complete parse of the api tree comments
		// And reenable that check
		//base.check (api_root, container, reporter);
	}

	private Run[]? split_run (Inline? separator) {
		if (separator == null) {
			return null;
		}

		ContentElement parent = separator.parent;
		Vala.List<Inline> parent_content = null;

		if (parent is Run && ((Run) parent).style == Run.Style.NONE) {
			parent_content = ((Run) parent).content;
		} else if (parent is Paragraph) {
			parent_content = ((Paragraph) parent).content;
		}

		if (parent_content != null) {
			Run right_run = new Run (Run.Style.NONE);
			Run left_run = new Run (Run.Style.NONE);
			bool separated = false;

			foreach (var current in parent_content) {
				if (current == separator) {
					separated = true;
				} else if (separated) {
					right_run.content.add (current);
					current.parent = right_run;
				} else {
					left_run.content.add (current);
					current.parent = left_run;
				}
			}

			return { left_run, right_run };
		}

		return null;
	}

	internal void transform (Api.Tree api_root, Api.Node container, string file_path,
							 ErrorReporter reporter, Settings settings)
	{
		ContentElement separator = this;
		Run right_run = null;
		Run left_run = null;
		Run[]? parts;

		while ((parts = split_run (separator as Inline)) != null) {
			if (left_run != null) {
				parts[0].content.add (left_run);
				left_run.parent = parts[0];
			}

			if (right_run != null) {
				parts[1].content.insert (0, right_run);
				right_run.parent = parts[1];
			}

			separator = separator.parent;
			right_run = parts[1];
			left_run = parts[0];
		}

		if (separator is Paragraph == false || separator.parent is Comment == false) {
			reporter.simple_error ("%s: %s: @inheritDoc".printf (file_path, container.get_full_name ()),
								   "Parent documentation can't be copied to this location.");
			return ;
		}

		Comment comment = separator.parent as Comment;
		assert (comment != null);

		int insert_pos = comment.content.index_of ((Paragraph) separator);
		int start_pos = insert_pos;
		assert (insert_pos >= 0);

		foreach (Block block in _inherited.documentation.content) {
			comment.content.insert (insert_pos, (Block) block.copy (comment));
			insert_pos++;
		}

		if (right_run != null) {
			if (comment.content[insert_pos - 1] is Paragraph) {
				((Paragraph) comment.content[insert_pos - 1]).content.add (right_run);
				right_run.parent = comment.content[insert_pos - 1];
			} else {
				Paragraph p = new Paragraph ();
				p.content.add (right_run);
				right_run.parent = p;
				p.parent = comment;
				comment.content.insert (insert_pos, p);
			}
		}

		if (left_run != null) {
			if (comment.content[start_pos] is Paragraph) {
				((Paragraph) comment.content[start_pos]).content.insert (0, left_run);
				left_run.parent = comment.content[start_pos];
			} else {
				Paragraph p = new Paragraph ();
				p.content.add (left_run);
				left_run.parent = p;
				p.parent = comment;
				comment.content.insert (start_pos, p);
			}
		}

		comment.content.remove ((Paragraph) separator);
	}

	private Run content_copy (Vala.List<ContentElement>? content) {
		Run run = new Run (Run.Style.NONE);
		run.parent = this;

		if (content != null) {
			foreach (ContentElement item in content) {
				run.content.add (item.copy (this) as Inline);
			}
		}

		return run;
	}

	public override ContentElement produce_content () {
		if (_inherited != null && _inherited.documentation != null && parent_taglet != null) {
			Vala.List<Taglet> parent_taglets = _inherited.documentation.find_taglets (null, parent_taglet.get_type ());
			foreach (Taglet parent in parent_taglets) {
				// we only care about the first match:
				if (parent.inheritable (parent_taglet)) {
					return content_copy (parent.get_inheritable_documentation ());
				}
			}
		}
		return new Text ("");
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		InheritDoc doc = new InheritDoc ();
		doc.parent = new_parent;

		doc.settings = settings;
		doc.locator = locator;

		doc._inherited = _inherited;

		return doc;
	}
}
