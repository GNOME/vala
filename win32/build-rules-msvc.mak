# NMake Makefile portion for compilation rules
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.  The format
# of NMake Makefiles here are different from the GNU
# Makefiles.  Please see the comments about these formats.

# Inference rules for compiling the .obj files.
# Used for libs and programs with more than a single source file.
# Format is as follows
# (all dirs must have a trailing '\'):
#
# {$(srcdir)}.$(srcext){$(destdir)}.obj::
# 	$(CC)|$(CXX) $(cflags) /Fo$(destdir) /c @<<
# $<
# <<

!ifndef REGEN_C_SOURCES
{..\gee\}.c{$(OUTDIR)\gee\}.obj::
	@if not exist $(OUTDIR)\gee\ md $(OUTDIR)\gee
	@if not exist config.h copy config.h.win32 config.h
	$(CC) $(LIBVALA_CFLAGS) $(LIBVALA_BUILD_INCLUDES) /Fo$(OUTDIR)\gee\ /Fd$(OUTDIR)\gee\ /c @<<
$<
<<

{..\vala\}.c{$(OUTDIR)\vala\}.obj::
	@if not exist $(OUTDIR)\vala\ md $(OUTDIR)\vala
	@if not exist config.h copy config.h.win32 config.h
	$(CC) $(LIBVALA_CFLAGS) $(LIBVALA_BUILD_INCLUDES) /Fo$(OUTDIR)\vala\ /Fd$(OUTDIR)\vala\ /c @<<
$<
<<

{..\ccode\}.c{$(OUTDIR)\ccode\}.obj::
	@if not exist $(OUTDIR)\ccode\ md $(OUTDIR)\ccode
	$(CC) $(LIBVALA_CCODE_CFLAGS) $(LIBVALA_BUILD_CCODE_INCLUDES) /Fo$(OUTDIR)\ccode\ /Fd$(OUTDIR)\ccode\ /c @<<
$<
<<

{..\codegen\}.c{$(OUTDIR)\codegen\}.obj::
	@if not exist $(OUTDIR)\codegen\ md $(OUTDIR)\codegen
	$(CC) $(LIBVALA_CODEGEN_CFLAGS) $(LIBVALA_BUILD_CODEGEN_INCLUDES) /Fo$(OUTDIR)\codegen\ /Fd$(OUTDIR)\codegen\ /c @<<
$<
<<

{..\compiler\}.c{$(OUTDIR)\compiler\}.obj::
	@if not exist $(OUTDIR)\compiler\ md $(OUTDIR)\compiler
	$(CC) $(VALAC_CFLAGS) $(VALA_FULL_INCLUDES) /Fo$(OUTDIR)\compiler\ /Fd$(OUTDIR)\compiler\ /c @<<
$<
<<

{..\vapigen\}.c{$(OUTDIR)\vapigen\}.obj::
	@if not exist $(OUTDIR)\vapigen\ md $(OUTDIR)\vapigen
	$(CC) $(VAPIGEN_CFLAGS) $(VAPIGEN_INCLUDES) /Fo$(OUTDIR)\vapigen\ /Fd$(OUTDIR)\vapigen\ /c @<<
$<
<<

!else

{$(OUTDIR)\gee\}.c{$(OUTDIR)\gee\}.obj::
	@if not exist config.h copy config.h.win32 config.h
	$(CC) $(LIBVALA_CFLAGS) $(LIBVALA_BUILD_INCLUDES) /Fo$(OUTDIR)\gee\ /Fd$(OUTDIR)\gee\ /c @<<
$<
<<

{$(OUTDIR)\vala\}.c{$(OUTDIR)\vala\}.obj::
	@if not exist config.h copy config.h.win32 config.h
	$(CC) $(LIBVALA_CFLAGS) $(LIBVALA_BUILD_INCLUDES) /Fo$(OUTDIR)\vala\ /Fd$(OUTDIR)\vala\ /c @<<
$<
<<

{$(OUTDIR)\ccode\}.c{$(OUTDIR)\ccode\}.obj::
	$(CC) $(LIBVALA_CCODE_CFLAGS) $(LIBVALA_BUILD_CCODE_INCLUDES) /Fo$(OUTDIR)\ccode\ /Fd$(OUTDIR)\ccode\ /c @<<
$<
<<

{$(OUTDIR)\codegen\}.c{$(OUTDIR)\codegen\}.obj::
	$(CC) $(LIBVALA_CODEGEN_CFLAGS) $(LIBVALA_BUILD_CODEGEN_INCLUDES) /Fo$(OUTDIR)\codegen\ /Fd$(OUTDIR)\codegen\ /c @<<
$<
<<

{$(OUTDIR)\compiler\}.c{$(OUTDIR)\compiler\}.obj::
	$(CC) $(VALAC_CFLAGS) $(VALA_FULL_INCLUDES) /Fo$(OUTDIR)\compiler\ /Fd$(OUTDIR)\compiler\ /c @<<
$<
<<

{$(OUTDIR)\gobject-introspection\}.c{$(OUTDIR)\gobject-introspection\}.obj::
	$(CC) $(BASE_CFLAGS) $(GOBJECT_INTROSPECTION_BUILD_INCLUDES) /Fo$(OUTDIR)\gobject-introspection\ /Fd$(OUTDIR)\gobject-introspection\ /c @<<
$<
<<

{$(OUTDIR)\vapigen\}.c{$(OUTDIR)\vapigen\}.obj::
	$(CC) $(VAPIGEN_CFLAGS) $(VAPIGEN_INCLUDES) /Fo$(OUTDIR)\vapigen\ /Fd$(OUTDIR)\vapigen\ /c @<<
$<
<<
!endif

{..\gobject-introspection\}.c{$(OUTDIR)\gobject-introspection\}.obj::
	@if not exist $(OUTDIR)\gobject-introspection\ md $(OUTDIR)\gobject-introspection
	$(CC) $(BASE_CFLAGS) $(GOBJECT_INTROSPECTION_BUILD_INCLUDES) /Fo$(OUTDIR)\gobject-introspection\ /Fd$(OUTDIR)\gobject-introspection\ /c @<<
$<
<<

# Rules for building .lib files
$(VALA_LIB): $(VALA_DLL)
$(VALA_CODEGEN_LIB): $(VALA_CODEGEN_DLL)

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(VALA_DLL): $(vala_libgee_objs) $(vala_libvala_objs)
$(VALA_CODEGEN_DLL): $(VALA_LIB) $(vala_libccode_objs) $(vala_libcodegen_objs)

$(VALA_CODEGEN_DLL) $(VALA_CCODE_DLL) $(VALA_DLL):
	link  /DLL $(LDFLAGS) 	\
	$(BASE_DEP_LIBS)	\
	/out:$@ @<<
$**
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(VALAC_EXE): $(VALA_CODEGEN_LIB) $(VALA_LIB) $(vala_libccode_objs) $(compiler_objs)
	link $(LDFLAGS) 	\
	$(BASE_DEP_LIBS)	\
	/delayload:valaccodegen.dll delayimp.lib	\
	/out:$@ @<<
$**
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1


$(GEN_INTROSPECT): $(gen_introspection_objs) $(gidl_objs)
$(VAPIGEN): $(vapigen_objs) $(gidl_objs) $(vala_libccode_objs) $(VALA_LIB)
$(VAPICHECK): $(vapicheck_objs) $(gidl_objs) $(vala_libccode_objs) $(VALA_LIB)

$(GEN_INTROSPECT) $(VAPIGEN) $(VAPICHECK):
	link $(LDFLAGS) 	\
	$(BASE_DEP_LIBS)	\
	/out:$@ @<<
$**
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

clean:
	@-del /f /q $(OUTDIR)\*.dll.manifest
	@-del /f /q $(OUTDIR)\*.dll
	@-del /f /q $(OUTDIR)\*.exe.manifest
	@-del /f /q $(OUTDIR)\*.exe
	@-del /f /q $(OUTDIR)\*.pdb
	@-del /f /q $(OUTDIR)\*.ilk
	@-del /f /q $(OUTDIR)\*.exp
	@-del /f /q $(OUTDIR)\*.lib
	@-if not "$(REGEN_C_SOURCES)" == "" del /f /q $(OUTDIR)\libvala$(LIB_SUFFIX).vapi
	@-for %d in (vapigen gobject-introspection compiler codegen ccode vala gee) do @for %x in (obj pdb) do @del $(OUTDIR)\%d\*.%x
	@-if not "$(REGEN_C_SOURCES)" == "" for %d in (vapigen gobject-introspection compiler codegen ccode vala gee) do @for %x in (c h vapi) do @del $(OUTDIR)\%d\*.%x
	@-for %d in (vapigen gobject-introspection compiler codegen ccode vala gee) do @rd $(OUTDIR)\%d
	@-del /s /q config.h
