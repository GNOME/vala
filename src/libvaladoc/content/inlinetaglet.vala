/* taglet.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Gee;


public abstract class Valadoc.Content.InlineTaglet : ContentElement, Taglet, Inline {
	protected Settings settings;
	protected ResourceLocator locator;
	private ContentElement _content;

	public InlineTaglet () {
		base ();
	}

	public abstract Rule? get_parser_rule (Rule run_rule);

	public abstract ContentElement produce_content ();

	private ContentElement get_content () {
		if (_content == null) {
			_content = produce_content ();
		}
		return _content;
	}

	public override void configure (Settings settings, ResourceLocator locator) {
		this.settings = settings;
		this.locator = locator;
	}

	public override void check (Tree api_root, Api.Node? container, ErrorReporter reporter) {
		ContentElement element = get_content ();
		element.check (api_root, container, reporter);
	}

	public override void accept (ContentVisitor visitor) {
		ContentElement element = get_content ();
		element.accept (visitor);
	}
}

