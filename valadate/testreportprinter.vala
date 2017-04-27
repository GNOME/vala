/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2017 Chris Daley <chebizarro@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

public abstract class Valadate.TestReportPrinter {

	public static TestReportPrinter @new(TestConfig config) throws Error {
		switch(config.format) {
			case "tap" :
				return new TapTestReportPrinter(config);
			case "xml" :
				return new XmlTestReportPrinter(config);
			case "gnu" :
				return new GnuTestReportPrinter(config);
			default:
				throw new TestConfigError.TEST_PRINTER("TestReportPrinter %s does not exist", config.format);
		}
	}
	
	public TestConfig config {get; set;}
	
	public TestReportPrinter(TestConfig config) throws Error {
		this.config = config;
	}

	public abstract void print(TestReport report);
	
}
