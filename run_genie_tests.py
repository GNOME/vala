#! /usr/bin/python3
"""
Place this file in the root of valac's sources.
Tests directory must be subdirectory to it.

Failed tests are saved to tests + ./failed folder.

It can be used only with Python 3.

Please, configure next variables (before imports) before running it.
"""


# pathes can be relative this file's path.
# Configure variables in this block:

compiler_path = "libtool --mode=execute ./compiler/valac"  # valac.
directories_with_tests = ["./tests"]  # will go across them recursively
place_for_failed_tests_binaries = "./tests/_failed"
use_dependencies = ["gee-0.8", "libvala-0.38"]
possible_extensions = [".gs"] # only files with this extensions will be proceeded




import os, os.path
import subprocess as sub
import sys
import shutil

cur_file_dir = os.path.dirname (__file__)
tests_base_dir = ""  # will change while going across "directories_with_tests"
tests_passed = 0
tests_failed = 0
color_blue = "\x1b[34m"  # for painting in terminal
color_green = "\x1b[32m"
color_red = "\x1b[31m"
color_reset = "\x1b[0m"





def run_tests():
	global tests_base_dir
	
	for cur_tests_dir in directories_with_tests:
		tests_base_dir = os.path.join(cur_file_dir, cur_tests_dir)
		cur_all_subdirs_with_tests = receive_subdirectories_recursively (tests_base_dir)
	
		for cur_dir in cur_all_subdirs_with_tests:
			src_files_list = receive_source_files_list (cur_dir)
		
			for cur_file in src_files_list:
				run_test (cur_file)
	
	print ("")
	totally_tests = tests_passed + tests_failed
	print ("Totally ran {totally_tests} tests.".format(totally_tests=totally_tests))
	print ("{color_green}Passed: {tests_passed};    {color_red}Failed: {tests_failed}.{color_reset}".format(
			color_green=color_green, tests_passed=tests_passed,
			tests_failed=tests_failed, color_reset=color_reset,
			color_red=color_red))
	print ("")


def run_test(test_src_path):
	"""Uses:
		build_test_bin ()
		print_result ()
		run_test_bin ()
		print_result ()
	"""
	global tests_failed, tests_passed
	test_name = os.path.relpath (test_src_path, tests_base_dir)
	
	build_command, test_bin_path = form_build_command (test_src_path)
	result_building = build_test_bin (build_command, test_name)
	
	if result_building['error']:  # build attempt
		print_result (result_building, test_name)
		tests_failed += 1
	else:  # build successful
		result_running = run_test_bin (test_bin_path, test_name)
		print_result (result_running, test_name)
		
		if not result_running['error']:
			tests_passed += 1
			os.remove (test_bin_path)
		else:
			tests_failed += 1
	
			bindir_relative = os.path.dirname (test_name)
			cur_failed_test_dir = os.path.join (cur_file_dir, place_for_failed_tests_binaries, bindir_relative)
			
			if not os.path.exists (cur_failed_test_dir):
				os.makedirs (cur_failed_test_dir)
			shutil.copy2 (test_bin_path, cur_failed_test_dir)
			os.remove (test_bin_path)


def run_test_bin (test_bin_path, test_name):
	"""returns: {'error':True, 'output':"text"}
	"""
	
	proc = sub.run("{test_bin_path}".format(test_bin_path=test_bin_path), stdout=sub.PIPE, stderr=sub.PIPE)
	output = str(proc.stdout, encoding='utf-8')
	
	if proc.returncode == 0:
		error = False
	else:
		error = True	
	
	return {'error':error, 'output':output, 'when':'running'}
		
		
def build_test_bin (command, test_name):
	"""Runs build command in other process.
	"""
	proc = sub.run([x1 for x1 in command.split (' ') if x1],  # to remove empty arguments
		stdout=sub.PIPE, stderr=sub.PIPE, shell=False)
	output = (str(proc.stdout, encoding='utf-8') + "\n" +
			str(proc.stderr, encoding='utf-8') + "\n" +
			str(proc.stdout, encoding='utf-8'))  # stdout - errors amount; stderr - errors text
	
	if proc.returncode == 0:
		error = False
	else:
		error = True
	
	return {'error':error, 'output':output, 'when':'building'}


def form_build_command (test_src_path):
	dependencies_list = [" --pkg=" + x1 for x1 in use_dependencies]
	packages = ""
	for x1 in dependencies_list:
		packages += x1
	packages = packages.lstrip()
	
	for ext in possible_extensions:
		if test_src_path.endswith (ext):
			test_bin_path = test_src_path [0: - len(ext)]
	output = "--output=" + test_bin_path
	
	command = "{compiler_path} {packages} {test_src_path} {output}".format(
			compiler_path=compiler_path, packages=packages,
			test_src_path=test_src_path, output=output)
	
	return command, test_bin_path


def print_result(result, test_name):
	"""In:
		result, returned by build_test_bin (), run_test_bin ()
		result = {'error':error, 'output':output, 'when':'when failed'}
	"""	
	print ("")
	if not result['error']:
		print ("{color_green}OK{color_reset}        ({test_name} {color_green}passed{color_reset})".format(
				color_green=color_green, color_reset=color_reset,
				test_name=test_name))
	else:
		result_when = result['when']
		print ("{color_red}FAILED{color_reset}    ({test_name} {color_red}failed {result_when}{color_reset})".format(
				color_red=color_red, color_reset=color_reset,
				test_name=test_name, result_when=result_when))
		
		print ("")
		result['output'] = result['output'].replace ("error", "{color_red}error{color_reset}".format(
				color_red=color_red, color_reset=color_reset))
		result['output'] = result['output'].replace ("^", "{color_red}^{color_reset}".format(
				color_red=color_red, color_reset=color_reset))
		
		print (result['output'])  # it'll be printed itself into stdout


def receive_abs_path_from_relative (rel_path):  # path must be relative to this file
	abs_path = os.path.join (cur_file_dir, rel_path)
	
	if os.path.exists(abs_path):
		return abs_path
	else:
		raise FileNotFoundError ("Such directory is absent: {abs_path}".format(abs_path=abs_path))


def receive_subdirectories_recursively (main_path):
	"""Returns absolute paths of subdirectories.
	"""
	subdirs_met = False
	met_subdirs = []
	for cur_path in os.listdir (main_path):
		cur_path = os.path.join (main_path, cur_path)
		
		if os.path.isdir (cur_path):
			childs_subdirs = receive_subdirectories_recursively (cur_path)
			met_subdirs.append (cur_path)
			met_subdirs.extend (childs_subdirs)
			subdirs_met = True
	
	if not subdirs_met:
		return []
	return met_subdirs


def receive_source_files_list (folder):
	"""Receives only files in current dir and only with
	supported extension.
	"""
	source_files_list = []
	
	for cur_file in os.listdir (folder):
		cur_file_path = os.path.join (folder, cur_file)
		
		if os.path.isfile (cur_file_path):
			for ext in possible_extensions:
				if cur_file_path.endswith (ext):
					source_files_list.append (cur_file_path)
	return source_files_list




run_tests ()
