/* sourcecomment.vala
 *
 * Copyright (C) 2011  Florian Brosch
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


/**
 * A documentation comment used by valadoc
 */
public class Valadoc.Api.SourceComment {
	public SourceFile file {
		private set;
		get;
	}

	/**
	 * The text describing the referenced source code.
	 */
	public string content {
		private set;
		get;
	}

	/**
	 * The first line number of the referenced source code.
	 */
	public int first_line {
		private set;
		get;
	}

	/**
	 * The first column number of the referenced source code.
	 */
	public int first_column {
		private set;
		get;
	}

	/**
	 * The last line number of the referenced source code.
	 */
	public int last_line {
		private set;
		get;
	}

	/**
	 * The last column number of the referenced source code.
	 */
	public int last_column {
		private set;
		get;
	}

	public SourceComment (string content, SourceFile file, int first_line, int first_column,
						  int last_line, int last_column)
	{
		this.first_column = first_column;
		this.last_column = last_column;
		this.first_line = first_line;
		this.last_line = last_line;
		this.content = content;
		this.file = file;
	}
}


