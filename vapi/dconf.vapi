/*
 * Copyright © 2009 Codethink Limited
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of the
 * licence, or (at your option) any later version.
 *
 * See the included COPYING file for more information.
 *
 * Author:
 *      Ryan Lortie <desrt@desrt.ca>
 */

[CCode (cname_prefix = "dconf_", cheader_filename = "dconf.h")]
namespace DConf {
	public delegate void AsyncReadyCallback (AsyncResult result);
	public struct AsyncResult { }

	public bool is_key (string key);
	public bool is_path (string path);
	public bool match (string left, string right);

	public GLib.Variant? get (string key);
	public string[] list (string path);
	public bool get_writable (string path);
	public bool get_locked (string path);

	public void set (string key, GLib.Variant value, out string event_id = null) throws GLib.Error;
	public void set_async (string key, GLib.Variant value, DConf.AsyncReadyCallback callback);
	public void set_finish (DConf.AsyncResult result, out string event_id = null) throws GLib.Error;

	public void set_locked (string key, bool value) throws GLib.Error;
	public void set_locked_async (string key, bool value, DConf.AsyncReadyCallback callback);
	public void set_locked_finish (DConf.AsyncResult result) throws GLib.Error;

	public void reset (string key, out string event_id = null) throws GLib.Error;
	public void reset_async (string key, DConf.AsyncReadyCallback callback);
	public void reset_finish (DConf.AsyncResult result, out string event_id = null) throws GLib.Error;

	public void merge (string prefix, GLib.Tree tree, out string event_id = null) throws GLib.Error;
	public void merge_async (string prefix, GLib.Tree tree, DConf.AsyncReadyCallback callback);
	public void merge_finish (DConf.AsyncResult result, out string event_id = null) throws GLib.Error;

	public delegate void WatchFunc (string prefix, string[] items, string event_id);
	public void watch (string path, WatchFunc callback);
	public void unwatch (string path, WatchFunc callback);
}
