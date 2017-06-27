/* contentvisitor.vala
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


public abstract class Valadoc.Content.ContentVisitor : Object {

	public virtual void visit_comment (Comment element) {
	}

	public virtual void visit_embedded (Embedded element) {
	}

	public virtual void visit_headline (Headline element) {
	}

	public virtual void visit_link (Link element) {
	}

	public virtual void visit_wiki_link (WikiLink element) {
	}

	public virtual void visit_symbol_link (SymbolLink element) {
	}

	public virtual void visit_list (List element) {
	}

	public virtual void visit_list_item (ListItem element) {
	}

	public virtual void visit_paragraph (Paragraph element) {
	}

	public virtual void visit_warning (Warning element) {
	}

	public virtual void visit_note (Note element) {
	}

	public virtual void visit_page (Page element) {
	}

	public virtual void visit_run (Run element) {
	}

	public virtual void visit_source_code (SourceCode element) {
	}

	public virtual void visit_table (Table element) {
	}

	public virtual void visit_table_cell (TableCell element) {
	}

	public virtual void visit_table_row (TableRow element) {
	}

	public virtual void visit_taglet (Taglet element) {
	}

	public virtual void visit_text (Text element) {
	}
}

