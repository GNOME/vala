/* errorreporter.vala
 *
 * Copyright (C) 2012       Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc;

void main () {
	var reporter = new Valadoc.ErrorReporter ();
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);

	// simple errors:
	reporter.simple_error ("test", "error 1 %d %s", 1, "foo");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 1);

	reporter.simple_error (null, "error 2");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 2);


	// simple warnings:
	reporter.simple_warning ("test", "warning 1 %d %s", 1, "foo");
	assert (reporter.warnings == 1);
	assert (reporter.errors == 2);

	reporter.simple_warning (null, "warning 2");
	assert (reporter.warnings == 2);
	assert (reporter.errors == 2);


	// errors:
	reporter.error ("file", 1, 1, 1, "line", "error, complex, 1 %d %s", 1, "foo");
	assert (reporter.warnings == 2);
	assert (reporter.errors == 3);

	reporter.error ("file", 1, 1, 1, "line", "error, complex, 2");
	assert (reporter.warnings == 2);
	assert (reporter.errors == 4);


	// warnngs:
	reporter.warning ("file", 1, 1, 1, "line", "warning, complex, 1 %d %s", 1, "foo");
	assert (reporter.warnings == 3);
	assert (reporter.errors == 4);

	reporter.warning ("file", 1, 1, 1, "line", "warning, complex, 2");
	assert (reporter.warnings == 4);
	assert (reporter.errors == 4);
}

