/* lazy.vala
 *
 * Copyright (C) 2011  Maciej Piechotka
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Maciej Piechotka <uzytkownik2@gmail.com>
 */

namespace Vala {
	public delegate G LazyFunc<G> ();
}

/**
 * Represents a lazy value. I.e. value that is computed on demand.
 */
public class Vala.Lazy<G> {
	public Lazy (owned LazyFunc<G> func) {
		_func = (owned)func;
	}

	public Lazy.from_value (G item) {
		_value = item;
	}

	public void eval () {
		if (_func != null) {
			_value = _func ();
			_func = null;
		}
	}

	public new G get () {
		eval ();
		return _value;
	}

	public new G value {
		get {
			eval ();
			return _value;
		}
	}

	private LazyFunc<G>? _func;
	private G? _value;
}
