/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2016  Chris Daley <chebizarro@gmail.com>
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
 * Authors:
 * 	Chris Daley <chebizarro@gmail.com>
 */

public abstract class Valadate.Assembly {

	private static SubprocessLauncher launcher;

	private static void init_launcher () {
		if (launcher == null) {
			launcher = new SubprocessLauncher (
				GLib.SubprocessFlags.STDIN_PIPE |
				GLib.SubprocessFlags.STDOUT_PIPE |
				GLib.SubprocessFlags.STDERR_PIPE);
			launcher.setenv ("G_MESSAGES_DEBUG","all",true);
			launcher.setenv ("G_DEBUG","fatal-criticals fatal-warnings gc-friendly",true);
			launcher.setenv ("G_SLICE","always-malloc debug-blocks",true);
		}
	}

	public File binary { get; set; }
	public InputStream stderr { get; set; }
	public OutputStream stdin { get; set; }
	public InputStream stdout { get; set; }

	private Subprocess process;

	public Assembly (File binary) throws Error {
		init_launcher ();
		if (!binary.query_exists ())
			throw new FileError.NOENT ("The file %s does not exist", binary.get_path ());
		if (!GLib.FileUtils.test (binary.get_path (), FileTest.IS_EXECUTABLE))
			throw new FileError.PERM ("The file %s is not executable", binary.get_path ());
		this.binary = binary;
	}

	public abstract Assembly clone () throws Error;

	public virtual Assembly run (string? command = null, Cancellable? cancellable = null) throws Error {
		string[] args;
		Shell.parse_argv ("%s %s".printf (binary.get_path (), command ?? ""), out args);
		process = launcher.spawnv (args);
		stdout = new DataInputStream (process.get_stdout_pipe ());
		stderr = new DataInputStream (process.get_stderr_pipe ());
		stdin = new DataOutputStream (process.get_stdin_pipe ());
		process.wait_check (cancellable);
		cancellable.set_error_if_cancelled ();
		return this;
	}

	public virtual void quit () {
		if (process != null)
			process.force_exit ();
	}
}
