/* 
 * Valadate - Unit testing library for GObject-based libraries.
 *
 * testcase.vala
 * Copyright (C) 2016 Chris Daley
 * Copyright (C) 2009-2012 Julien Peeters
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
 * 	Julien Peeters <contact@julienpeeters.fr>
 */

public errordomain Valadate.TestError {
	NOT_FOUND
}

public abstract class Valadate.TestCase : Object, Test, TestFixture {

	/**
	 * The TestMethod delegate represents a {@link Valadate.Test} method
	 * that can be added to a TestCase and run
	 */
	public delegate void TestMethod ();

	/**
	 * the name of the TestCase
	 */
	public string name { get; set; }

	/**
	 * The public constructor takes an optional string parameter for the
	 * TestCase's name
	 */
	public TestCase(string? name = null) {
		this.name = name;
	}

	/**
	 * Returns the number of {@link Valadate.Test}s that will be run by this TestCase
	 */
	public int count {get;set;}

	
	public void run(TestResult result) {

		result.run(this);
		
		return result;
	}



	private HashTable<string, TestAdaptor> _tests =
		new HashTable<string, TestAdaptor> (str_hash, str_equal);


	private class TestAdaptor : Object, Test {

		public string name { get; set; }

		private Test.TestMethod test;
		
		public TestAdaptor(string name, owned Test.TestMethod test) {
			this.name = name;
			this.test = (owned)test;
		}

		public TestResult? run(TestResult? result = null) {
			this.test();
			return result;
		}

	}

	public void add_test (string name, owned Test.TestMethod test)
		requires (name.contains("/") != true)
	{
		var adaptor = new TestAdaptor (name, (owned)test);
		_tests.insert(name, adaptor);
	}





	public virtual void set_up() {}

	public virtual void tear_down() {}










	



	public delegate void AsyncBegin(AsyncReadyCallback callback);
	public delegate void AsyncFinish(AsyncResult result) throws GLib.Error;

	public GLib.TestSuite _suite;

	public GLib.TestSuite suite {
		get {
			if (_suite == null)
				_suite = new GLib.TestSuite (this.name);
			return _suite;
		}
	}


	private Adaptor[] adaptors = new Adaptor[0];


	
	construct {
		name = this.get_type().name();
	}

	public void add_testb (string name, owned Test.TestMethod test)
		requires (name.contains("/") != true)
	{
		var adaptor = new Adaptor (name, (owned)test, this);
		this.adaptors += adaptor;

		//this._tests.insert(name, adaptor);

		this.suite.add (new GLib.TestCase (adaptor.name,
										   adaptor.set_up,
										   adaptor.run,
										   adaptor.tear_down ));
	}


	public void add_async_test (
		string name,
		owned AsyncBegin async_begin,
		owned AsyncFinish async_finish,
		int timeout = 200)
	{
		var adaptor = new Adaptor (name, () => { }, this);
		adaptor.is_async = true;
		adaptor.async_begin = (owned)async_begin;
		adaptor.async_finish = (owned)async_finish;
		adaptor.async_timeout = timeout;
		this.adaptors += adaptor;

		//this._tests.insert(name, adaptor);

		this.suite.add (new GLib.TestCase (
			adaptor.name,
			adaptor.set_up,
			adaptor.run,
			adaptor.tear_down,
			sizeof(Adaptor)));

	}





	private class Adaptor {
		[CCode (notify = false)]
		public string name { get; private set; }
		public int async_timeout { get; set; }

		private Test.TestMethod test;
		private TestCase test_case;

		public bool is_async = false;
		public AsyncBegin async_begin;
		public AsyncFinish async_finish;

		public Adaptor (string name,
						owned Test.TestMethod test,
						TestCase test_case) {
			this.name = name;
			this.test = (owned)test;
			this.test_case = test_case;
		}

		public void set_up (void* fixture) {
			GLib.set_printerr_handler (printerr_func_stack_trace);
			Log.set_default_handler (log_func_stack_trace);
			this.test_case.set_up ();
		}

		private static void printerr_func_stack_trace (string? text) {
			if (text == null || str_equal (text, ""))
				return;

			stderr.printf (text);

			/* Print a stack trace since we've hit some major issue */
			GLib.on_error_stack_trace ("libtool --mode=execute gdb");
		}

		private void log_func_stack_trace (
			string? log_domain,
			LogLevelFlags log_levels,
			string message)	{
			Log.default_handler (log_domain, log_levels, message);

			/* Print a stack trace for any message at the warning level or above */
			if ((log_levels & (
				LogLevelFlags.LEVEL_WARNING |
				LogLevelFlags.LEVEL_ERROR |
				LogLevelFlags.LEVEL_CRITICAL)) != 0) {
				GLib.on_error_stack_trace ("libtool --mode=execute gdb");
			}
		}

		public void run (void* fixture)	{
			if (this.is_async) {
				try	{
					assert( wait_for_async (async_timeout, this.async_begin, this.async_finish) );
				}
				catch (GLib.Error err) {
					message(@"Got exception while excuting asynchronous test: $(err.message)");
					GLib.Test.fail();
				}
			} else {
				this.test();
			}
		}


		public void tear_down (void* fixture) {
			this.test_case.tear_down ();
		}
		
		public bool wait_for_async(int timeout, AsyncBegin async_function, AsyncFinish async_finish) throws GLib.Error {
			var loop = new MainLoop(MainContext.default(), true);
			AsyncResult? result = null;
			// Plan the async function
			async_function((o, r) => { result = r; loop.quit(); });
			// Plan timeout
			var t1 = Timeout.add(timeout, () => { loop.quit(); return false; });
			// Run the loop if it was not quit yet.
			if(loop.is_running())
				loop.run();
			// Cancel timer
			Source.remove(t1);
			// Check the outcome
			if(result == null)
				return false;
			async_finish(result);
			return true;
		}
	}
}
