/* valacodecontext.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

namespace Vala {
	public class CodeContext {
		List<SourceFile> source_files;
		public Symbol root = new Symbol ();
		
		List<SourceFileCycle> cycles;
		
		public ref List<SourceFile> get_source_files () {
			return source_files.copy ();
		}
		
		public void add_source_file (SourceFile! file) {
			source_files.append (file);
		}
		
		public void accept (CodeVisitor! visitor) {
			foreach (SourceFile file in source_files) {
				file.accept (visitor);
			}
		}
		
		public void find_header_cycles () {
			/* find cycles in dependencies between source files */
			foreach (SourceFile file in source_files) {
				/* we're only interested in internal source files */
				if (!file.pkg) {
					if (file.mark == 0) {
						visit (file, null);
					}
				}
			}
			
			/* find one head for each cycle, it must not have any
			 * hard dependencies on other files in the cycle
			 */
			foreach (SourceFileCycle cycle in cycles) {
				cycle.head = find_cycle_head ((SourceFile) cycle.files.data);
				cycle.head.is_cycle_head = true;
			}

			/* connect the source files in a non-cyclic way
			 * cycle members connect to the head of their cycle
			 */
			foreach (SourceFile file2 in source_files) {
				/* we're only interested in internal source files */
				if (!file2.pkg) {
					foreach (SourceFile dep in file2.header_internal_dependencies) {
						if (file2.cycle != null && dep.cycle == file2.cycle) {
							/* in the same cycle */
							if (!file2.is_cycle_head) {
								/* include header of cycle head */
								file2.header_internal_includes.append (file2.cycle.head.get_cheader_filename ());
							}
						} else {
							/* we can just include the headers if they are not in a cycle or not in the same cycle as the current file */
							file2.header_internal_includes.append (dep.get_cheader_filename ());
						}
					}
				}
			}
			
		}
		
		private SourceFile find_cycle_head (SourceFile! file) {
			foreach (SourceFile dep in file.header_internal_full_dependencies) {
				foreach (SourceFile cycle_file in file.cycle.files) {
					if (dep == cycle_file) {
						return find_cycle_head (dep);
					}
				}
			}
			/* no hard dependencies on members of the same cycle found
			 * source file suitable as cycle head
			 */
			return file;
		}
		
		private void visit (SourceFile! file, List<SourceFile> chain) {
			/* no deep copy available yet
			 * var l = chain.copy ();
			 */
			ref List<ref SourceFile> l = null;
			foreach (SourceFile chain_file in chain) {
				l.append (chain_file);
			}
			l.append (file);
			/* end workaround */

			/* mark file as currently being visited */
			file.mark = 1;
			
			foreach (SourceFile dep in file.header_internal_dependencies) {
				if (file != dep) {
					if (dep.mark == 1) {
						/* found cycle */
						
						var cycle = new SourceFileCycle ();
						cycles.append (cycle);
						
						bool cycle_start_found = false;
						foreach (SourceFile cycle_file in l) {
							ref SourceFileCycle ref_cycle_file_cycle = cycle_file.cycle;
							if (!cycle_start_found) {
								if (cycle_file == dep) {
									cycle_start_found = true;
								}
							}
							if (cycle_start_found) {
								if (cycle_file.cycle != null) {
									/* file already in a cycle */
									if (cycle_file.cycle != cycle) {
										/* file is in an other cycle, merge the two cycles */
										
										/* broken memory management cycles.remove (cycle_file.cycle); */
										ref List<ref SourceFileCycle> newlist = null;
										foreach (SourceFileCycle oldcycle in cycles) {
											if (oldcycle != cycle_file.cycle) {
												newlist.append (oldcycle);
											}
										}
										cycles = null;
										foreach (SourceFileCycle newcycle in newlist) {
											cycles.append (newcycle);
										}
										newlist = null;
										/* end workaround for broken memory management */
										
										foreach (SourceFile inner_cycle_file in cycle_file.cycle.files) {
											if (inner_cycle_file.cycle != cycle) {
												/* file in inner cycle not yet added to outer cycle */
												cycle.files.append (inner_cycle_file);
												inner_cycle_file.cycle = cycle;
											}
										}
									}
								} else {
									cycle.files.append (cycle_file);
									cycle_file.cycle = cycle;
								}
							}
						}
					} else if (dep.mark == 0) {
						/* found not yet visited file */
						
						visit (dep, l);
					}
				}
			}
			
			/* mark file as successfully visited */
			file.mark = 2;
		}
	}
}
