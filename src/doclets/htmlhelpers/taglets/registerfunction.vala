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

using Valadoc;


[ModuleInit]
public void register_plugin (ModuleLoader loader) {
	loader.underline = typeof (Valadoc.Html.UnderlinedDocElement);
	loader.table_cell = typeof (Valadoc.Html.TableCellDocElement);
	loader.table = typeof (Valadoc.Html.TableDocElement);
	loader.string = typeof (Valadoc.Html.StringTaglet);
	loader.source = typeof (Valadoc.Html.SourceCodeDocElement);
	loader.right = typeof (Valadoc.Html.RightAlignedDocElement);
	loader.paragraph = typeof (Valadoc.Html.ParagraphDocElement);
	loader.notification = typeof (Valadoc.Html.NotificationDocElement);
	loader.list_element = typeof (Valadoc.Html.ListEntryDocElement);
	loader.list = typeof (Valadoc.Html.ListDocElement);
	loader.link = typeof (Valadoc.Html.LinkDocElement);
	loader.italic = typeof (Valadoc.Html.ItalicDocElement);
	loader.image = typeof (Valadoc.Html.ImageDocElement);
	loader.headline = typeof (Valadoc.Html.HeadlineDocElement);
	loader.source_inline = typeof (Valadoc.Html.CodeConstantDocElement);
	loader.center = typeof (Valadoc.Html.CenterDocElement);
	loader.bold = typeof (Valadoc.Html.BoldDocElement);

	loader.taglets.set ("see", typeof (Valadoc.Html.SeeTaglet));
	loader.taglets.set ("since", typeof (Valadoc.Html.SinceTaglet));
	loader.taglets.set ("link", typeof (Valadoc.Html.TypeLinkInlineTaglet));
	loader.taglets.set ("throws", typeof (Valadoc.Html.ExceptionTaglet));
	loader.taglets.set ("return", typeof (Valadoc.Html.ReturnTaglet));
	loader.taglets.set ("param", typeof (Valadoc.Html.ParameterTaglet));
}


