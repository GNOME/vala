# Convert the source listing to object (.obj) listing in
# another NMake Makefile module, include it, and clean it up.
# This is a "fact-of-life" regarding NMake Makefiles...
# This file does not need to be changed unless one is maintaining the NMake Makefiles

# For those wanting to add things here:
# To add a list, do the following:
# # $(description_of_list)
# if [call create-lists.bat header $(makefile_snippet_file) $(variable_name)]
# endif
#
# if [call create-lists.bat file $(makefile_snippet_file) $(file_name)]
# endif
#
# if [call create-lists.bat footer $(makefile_snippet_file)]
# endif
# ... (repeat the if [call ...] lines in the above order if needed)
# !include $(makefile_snippet_file)
#
# (add the following after checking the entries in $(makefile_snippet_file) is correct)
# (the batch script appends to $(makefile_snippet_file), you will need to clear the file unless the following line is added)
#!if [del /f /q $(makefile_snippet_file)]
#!endif

# In order to obtain the .obj filename that is needed for NMake Makefiles to build DLLs/static LIBs or EXEs, do the following
# instead when doing 'if [call create-lists.bat file $(makefile_snippet_file) $(file_name)]'
# (repeat if there are multiple $(srcext)'s in $(source_list), ignore any headers):
# !if [for %c in ($(source_list)) do @if "%~xc" == ".$(srcext)" @call create-lists.bat file $(makefile_snippet_file) $(intdir)\%~nc.obj]
#
# $(intdir)\%~nc.obj needs to correspond to the rules added in build-rules-msvc.mak
# %~xc gives the file extension of a given file, %c in this case, so if %c is a.cc, %~xc means .cc
# %~nc gives the file name of a given file without extension, %c in this case, so if %c is a.cc, %~nc means a

NULL=

# For vala
!if [for %d in ($(PREFIX)) do @echo INSTALLPREFIX=%~dpfd>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & echo.>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %d in (gee vala ccode codegen) do @for %s in (real_sources gen_c_sources objs) do @echo vala_lib%d_%s =>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %d in (compiler vapigen) do @for %s in (real_sources gen_c_sources objs) do @echo %d_%s =>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(libgee_la_VALASOURCES:.vala=)) do @echo vala_libgee_real_sources = ^$(vala_libgee_real_sources) ..\gee\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo vala_libgee_gen_c_sources = ^$(vala_libgee_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\gee\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo vala_libgee_objs = ^$(vala_libgee_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\gee\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(libvala_la_VALASOURCES:.vala=)) do @echo vala_libvala_real_sources = ^$(vala_libvala_real_sources) ..\vala\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo vala_libvala_gen_c_sources = ^$(vala_libvala_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\vala\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo vala_libvala_objs = ^$(vala_libvala_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\vala\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(libvalaccode_la_VALASOURCES:.vala=)) do @echo vala_libccode_real_sources = ^$(vala_libccode_real_sources) ..\ccode\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo vala_libccode_gen_c_sources = ^$(vala_libccode_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\ccode\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo vala_libccode_objs = ^$(vala_libccode_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\ccode\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(libvalaccodegen_la_VALASOURCES:.vala=)) do @echo vala_libcodegen_real_sources = ^$(vala_libcodegen_real_sources) ..\codegen\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo vala_libcodegen_gen_c_sources = ^$(vala_libcodegen_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\codegen\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo vala_libcodegen_objs = ^$(vala_libcodegen_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\codegen\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(valac_VALASOURCES:.vala=)) do @echo compiler_real_sources = ^$(compiler_real_sources) ..\compiler\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo compiler_gen_c_sources = ^$(compiler_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\compiler\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo compiler_objs = ^$(compiler_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\compiler\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(vapigen_VALASOURCES:.vala=)) do @echo vapigen_real_sources = ^$(vapigen_real_sources) ..\vapigen\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo vapigen_gen_c_sources = ^$(vapigen_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\vapigen\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo vapigen_objs = ^$(vapigen_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\vapigen\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [for %s in ($(vapicheck_VALASOURCES:.vala=)) do @echo vapicheck_real_sources = ^$(vapicheck_real_sources) ..\vapigen\%s.vala>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
     @echo vapicheck_gen_c_sources = ^$(vapicheck_gen_c_sources) vs^$(VSVER)\^$(CFG)\^$(PLAT)\vapigen\%s.c>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak & \
	 @echo vapicheck_objs = ^$(vapicheck_objs) vs^$(VSVER)\^$(CFG)\^$(PLAT)\vapigen\%s.obj>>vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [call create-lists.bat header vala_vs$(VSVER)_$(CFG)_$(PLAT).mak gidl_objs]
!endif

!if [for %s in ($(libgidl_la_SOURCES)) do @if "%~xs" == ".c" call create-lists.bat file vala_vs$(VSVER)_$(CFG)_$(PLAT).mak vs$(VSVER)\$(CFG)\$(PLAT)\gobject-introspection\%~ns.obj]
!endif

!if [call create-lists.bat footer vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!if [call create-lists.bat header vala_vs$(VSVER)_$(CFG)_$(PLAT).mak gen_introspection_objs]
!endif

!if [for %s in ($(gen_introspect_SOURCES) scannerlexer.c scannerparser.c) do @if "%~xs" == ".c" call create-lists.bat file vala_vs$(VSVER)_$(CFG)_$(PLAT).mak vs$(VSVER)\$(CFG)\$(PLAT)\gobject-introspection\%~ns.obj]
!endif

!if [call create-lists.bat footer vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif

!include vala_vs$(VSVER)_$(CFG)_$(PLAT).mak

!if [del /f /q vala_vs$(VSVER)_$(CFG)_$(PLAT).mak]
!endif