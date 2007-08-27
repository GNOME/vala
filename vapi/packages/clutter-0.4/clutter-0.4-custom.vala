/* clutter-2.0.vala
 *
 * Copyright (C) 2007  Alberto Ruiz
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Alberto Ruiz <aruiz@gnome.org>
 */

namespace Clutter {
	[Import]
	public uint ramp_inc_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint ramp_dec_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint ramp_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint sine_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint sine_inc_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint sine_dec_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint sine_half_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint square_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint smoothstep_inc_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint smoothstep_dec_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint exp_inc_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public uint exp_dec_func (Clutter.Alpha alpha, pointer dummy);
	[Import]
	public void init (out string[] args);
	[Import]
	public void main ();
	[Import]
	public void main_quit ();
}
