/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2017  Chris Daley <chebizarro@gmail.com>
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

public class Valadate.TestReport {

	private const string XML_DECL ="<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	private const string TESTSUITE_XML =
		"""<testsuite disabled="" errors="" failures="" hostname="" id="" """ +
		"""name="" package="" skipped="" tests="" time="" timestamp="" >"""+
		"""<properties/></testsuite>""";
	private const string TESTCASE_XML =
		"""<testcase assertions="" classname="" name="" status="" time="" />""";
	private const string MESSAGE_XML = "<%s message=\"%s\" type=\"%s\">%s</%s>";
	private const string TESTCASE_START =
		"<testcase assertions=\"\" classname=\"%s\" name=\"%s\" status=\"\" time=\"\">";
	private const string VDX_NS = "xmlns:vdx=\"https://www.valadate.org/vdx\"";
	private const string TESTCASE_TAG = "testcase";
	private const string ROOT_TAG = "root";
	private const string SKIP_TAG = "skipped";
	private const string ERROR_TAG = "error";
	private const string FAILURE_TAG = "failure";
	private const string INFO_TAG = "info";
	private const string TIMER_TAG = "timer";
	private const string SYSTEM_OUT_TAG = "system-out";
	private const string SYSTEM_ERR_TAG = "system-err";

	public Test test { get; set; }
	public bool subprocess { get; set; }

	public XmlFile xml { get; set; }

	private static int64 start_time;
	private static int64 end_time;

	private static Regex regex_err;
	private const string regex_err_string =
		"""(\*{2}\n([A-Z]*):([\S]*)([\S ]*)\n)""";

	public TestReport (Test test, bool subprocess) throws Error {
		this.test = test;
		this.subprocess = subprocess;

		if (test.status == TestStatus.NOT_RUN)
			test.status = TestStatus.RUNNING;

		if (subprocess) {
			Log.set_default_handler (log_func);
			GLib.set_printerr_handler (printerr_func);
			regex_err = new Regex (regex_err_string);
		}

		if (test is TestSuite || test is TestCase)
			new_testsuite ();
		else if (test is TestAdapter)
			new_testcase ();
	}

	private void new_testsuite () throws Error {
		if (subprocess)
			return;

		var decl = "%s<%s>%s</%s>".printf (XML_DECL, ROOT_TAG, TESTSUITE_XML, ROOT_TAG);
		var doc = Xml.Parser.read_memory (decl, decl.length);
		var root = doc->get_root_element ()->children;
		root->set_prop ("tests", test.count.to_string ());
		root->set_prop ("name",test.label);
		xml = new XmlFile.from_doc (doc);
	}

	private void new_testcase () throws Error {
		if (subprocess) {
			stderr.printf ("%s<%s>",XML_DECL,ROOT_TAG);
			stderr.printf (TESTCASE_START, Type.from_instance (test.parent).name (), test.label);
			start_time = get_monotonic_time ();
		} else {
			var decl = "%s<%s>%s</%s>".printf (XML_DECL, ROOT_TAG, TESTCASE_XML, ROOT_TAG);
			var doc = Xml.Parser.read_memory (decl, decl.length);
			var root = doc->get_root_element ()->children;
			root->set_prop ("classname", ((TestAdapter)test).parent.name);
			root->set_prop ("status",test.status.to_string ().substring (21));
			root->set_prop ("name",test.label);
			xml = new XmlFile.from_doc (doc);
		}
	}

	public void add_error (string message) {
		if (test.status != TestStatus.SKIPPED &&
			test.status != TestStatus.TODO)
			test.status = TestStatus.ERROR;

		add_message (ERROR_TAG, message);

		if (subprocess) {
			emit_timer ();
			stderr.printf ("</%s></%s>",TESTCASE_TAG, ROOT_TAG);
			stderr.putc (0);
		}
		update_status ();
	}

	public void add_failure (string message) {
		if (test.status != TestStatus.SKIPPED &&
			test.status != TestStatus.TODO)
			test.status = TestStatus.FAILED;

		add_message (FAILURE_TAG, message);

		if (subprocess) {
			emit_timer ();
			stderr.printf ("</%s></%s>",TESTCASE_TAG, ROOT_TAG);
			stderr.putc (0);
		}
		update_status ();
	}

	public void add_skip (string message) {
		test.status = TestStatus.SKIPPED;
		add_message (SKIP_TAG, message);
		update_status ();
	}

	public void add_success () {
		if (test.status != TestStatus.SKIPPED &&
			test.status != TestStatus.TODO)
			test.status = TestStatus.PASSED;
		if (subprocess) {
			emit_timer ();
			stderr.printf ("</%s></%s>",TESTCASE_TAG, ROOT_TAG);
			stderr.putc (0);
		}
		update_status ();
	}

	private void add_message (string tag, string message) {
		var escaped = Markup.escape_text (message);
		if (subprocess) {
			stderr.printf (MESSAGE_XML, tag, escaped, tag.up (), message, tag);
		} else {
			Xml.Node* child = new Xml.Node (null, tag);
			child->set_content (escaped);

			string[] tags = {ERROR_TAG, FAILURE_TAG, INFO_TAG};

			if (tag in tags) {
				child->new_prop ("message", escaped);
				child->new_prop ("type", tag.up ());
			}

			Xml.Node* root = xml.eval ("//testcase | //testsuite")[0];
			root->add_child (child);
		}
	}
	/**
	 * Adds arbitrary text to the TestReport. In the xml output this
	 * text will be encapsulated in <system-out/> or <system-err/> tag
	 *
	 * @param text The text to be added to the {@link TestReport}.
	 * the text will be escaped before being added.
	 * @param tag The tag to use for adding the text
	 */
	public void add_text (string text, string tag) {
		var markup = Markup.escape_text (text);
		Xml.Node* child = new Xml.Node (null, tag);
		child->set_content (markup);

		string[] tags = {ERROR_TAG, FAILURE_TAG, INFO_TAG};

		if (tag in tags) {
			child->new_prop ("message", markup);
			child->new_prop ("type", tag.up ());
		}

		Xml.Node* root = xml.eval ("//testcase | //testsuite")[0];
		root->add_child (child);
	}

	public void update_status () {
		if (test is TestAdapter && !subprocess) {
			Xml.Node* root = xml.eval ("//testcase")[0];
			root->set_prop ("status",test.status.to_string ().substring (21));
			root->set_prop ("time",test.time.to_string ());
		}
	}

	private static void emit_timer () {
		end_time = get_monotonic_time ();
		var ms = "%f".printf (((double) (end_time-start_time))/1000);
		stderr.printf (MESSAGE_XML, TIMER_TAG, ms, TIMER_TAG, ms, TIMER_TAG);
	}

	private static void printerr_func (string? text) {
		if (text == null)
			return;
		MatchInfo info;
		if (regex_err.match (text, 0, out info)) {
			var escaped = Markup.escape_text (info.fetch (4));
			stderr.printf (MESSAGE_XML, ERROR_TAG, escaped, ERROR_TAG, text, ERROR_TAG);
			emit_timer ();
			stderr.printf ("</%s></%s>",TESTCASE_TAG, ROOT_TAG);
			stderr.putc (0);
		}
	}

	private void log_func (
		string? log_domain,
		LogLevelFlags log_levels,
		string? message)	{

		if (((log_levels & LogLevelFlags.LEVEL_INFO) != 0) ||
			((log_levels & LogLevelFlags.LEVEL_MESSAGE) != 0) ||
			((log_levels & LogLevelFlags.LEVEL_DEBUG) != 0)) {
			add_message (INFO_TAG, message);
		} else {
			add_error (message);
		}
	}

	public void process_buffer (string buffer) throws Error {

		xml = new XmlFile.from_string (buffer);

		var bits = xml.eval ("//testcase/text ()");

		if (bits.size != 0) {
			Xml.Node* textnode = bits[0];
			add_message (SYSTEM_ERR_TAG, textnode->get_content ());
			textnode->unlink ();
		}

		var errs = xml.eval ("//failure | //error");
		if (errs.size > 0 &&
			test.status != TestStatus.SKIPPED &&
			test.status != TestStatus.TODO)
			test.status = TestStatus.FAILED;

		bits = xml.eval ("//timer");
		Xml.Node* timer = bits[0];
		test.time = double.parse (timer->get_content ());
		timer->unlink ();

		update_status ();
	}

	public void add_stdout (string text) {
		add_message (SYSTEM_OUT_TAG, text);
	}
}
