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
	loader.underline = typeof (Valadoc.ValadocOrg.UnderlinedDocElement);
	loader.table_cell = typeof (Valadoc.ValadocOrg.TableCellDocElement);
	loader.table = typeof (Valadoc.ValadocOrg.TableDocElement);
	loader.string = typeof (Valadoc.ValadocOrg.StringTaglet);
	loader.source = typeof (Valadoc.ValadocOrg.SourceCodeDocElement);
	loader.right = typeof (Valadoc.ValadocOrg.RightAlignedDocElement);
	loader.paragraph = typeof (Valadoc.ValadocOrg.ParagraphDocElement);
	loader.notification = typeof (Valadoc.ValadocOrg.NotificationDocElement);
	loader.list_element = typeof (Valadoc.ValadocOrg.ListEntryDocElement);
	loader.list = typeof (Valadoc.ValadocOrg.ListDocElement);
	loader.link = typeof (Valadoc.ValadocOrg.LinkDocElement);
	loader.italic = typeof (Valadoc.ValadocOrg.ItalicDocElement);
	loader.image = typeof (Valadoc.ValadocOrg.ImageDocElement);
	loader.headline = typeof (Valadoc.ValadocOrg.HeadlineDocElement);
	loader.source_inline = typeof (Valadoc.ValadocOrg.CodeConstantDocElement);
	loader.center = typeof (Valadoc.ValadocOrg.CenterDocElement);
	loader.bold = typeof (Valadoc.ValadocOrg.BoldDocElement);

	loader.taglets.set ("see", typeof (Valadoc.ValadocOrg.SeeTaglet));
	loader.taglets.set ("since", typeof (Valadoc.ValadocOrg.SinceTaglet));
	loader.taglets.set ("link", typeof (Valadoc.ValadocOrg.TypeLinkInlineTaglet));
	loader.taglets.set ("throws", typeof (Valadoc.ValadocOrg.ExceptionTaglet));
	loader.taglets.set ("return", typeof (Valadoc.ValadocOrg.ReturnTaglet));
	loader.taglets.set ("param", typeof (Valadoc.ValadocOrg.ParameterTaglet));
}


