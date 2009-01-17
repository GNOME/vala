/* lua.vapi
 *
 * Copyright (C) 2008 pancake
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
 * 	pancake <youterm.com>
 */

[CCode (lower_case_cprefix = "lua_", cheader_filename = "lua.h")]
namespace Lua {
	[CCode (cname="lua_CFunction")]
	public static delegate int Callback(LuaVM vm);

	[CCode (free_function = "lua_close", cname = "lua_State", cprefix = "lua_")]
	[Compact]
	public class LuaVM {
		/* creation methods */
		[CCode (cname="(lua_State*)lua_open")]
		public static LuaVM open();
		[CCode (cname="lua_newthread")]
		public LuaVM new_thread();
		public void close();
		public int gc(int what, int data);
		public int getgccount();
		[CCode (cname="luaL_openlibs")]
		public void openlibs();

		/* stack manipulation */
		public int gettop();
		public void settop(int idx);
		public void pushvalue(int idx);
		public void remove(int idx);
		public void insert(int idx);
		public void replace(int idx);
		public int checkstack(int sz);
		public static void xmove(LuaVM from, LuaVM to, int n);

		/* code loading */
		[CCode (cname = "luaL_loadbuffer")]
		public int load_buffer(string cmd, int len);

		/* access functions */
		public int isnumber(int idx);
		public int isstring(int idx);
		public int iscfunction(int idx);
		public int isuserdata(int idx);
		public int type(int idx);
		public weak string typename(int tp);

		public int equal(int idx1, int idx2);
		public int rawequal(int idx1, int idx2);
		public int lessthan(int idx1, int idx2);

		// TODO: tonumber, tointeger
		public double tonumber(int idx);
		public int tointeger(int idx);
		public LuaVM tothread(int idx);
		public void* topointer(int idx);
		public Callback tocfunction(int idx);
		public int toboolean(int idx1);

		//[CCode (cname = "lua_register")]
		public void register(string name, Callback fun);
		public void pushcfunction(Callback fun);

		/* push functions */
		public void pushnil();
		public void pushnumber();
		public void pushlstring(string s, int len);
		public void pushstring(string s);
		//public void pushvfstring(weak string s);
		public void pushboolean(int b);
		public void pushlightuserdata(void* p);
		public void pushthread(LuaVM vm);

		/* get functions */
		public void gettable(int idx);
		public void getfield(int idx, string k);
		public void rawget(int idx);
		public void rawgeti(int idx, int n);
		public void createtable(int narr, int nrec);
		public void* newuserdata(int sz);
		public int getmetatable(int objindex);
		public void getfenv(int idx);

		/* set functions */
		public void settable(int idx);
		public void setfield(int idx, string k);
		public void rawset(int idx);
		public void rawseti(int idx, int n);
		public int setmetatable(int objindex);
		public void setfenv(int idx);

		/* call functions */
		public void call(int nargs=0, int nresults=0);
		public int pcall(int nargs=0, int nresults=0, int errfunc=0);
		public int cpcall(Callback fun, void* ud);
//TODO		public int load(lua_Reader reader, pointer ud, weak string chunkname);

		/* some useful macros */
		public int pop(int idx);
		public void newtable();
		public int strlen(int n);
		public bool isnil(int n);
		public bool isboolean(int n);
		public bool isthread(int n);
		public bool isnone(int n);
		public bool isnoneornil(int n);
		public void pushliteral(string s);
		public weak string tostring(int idx);

		/* coroutine functions */
		public int yield(int nresults);
		public int resume(int narg);
		public int status();
	}
}
