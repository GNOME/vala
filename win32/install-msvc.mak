# NMake Makefile snippet for copying the built libraries, utilities and headers to
# a path under $(PREFIX).

install: all
	@if not exist $(PREFIX)\bin\ mkdir $(PREFIX)\bin
	@if not exist $(PREFIX)\lib\vala$(LIB_SUFFIX)\ mkdir $(PREFIX)\lib\vala$(LIB_SUFFIX)
	@if not exist $(PREFIX)\include\vala$(LIB_SUFFIX)\ mkdir $(PREFIX)\include\vala$(LIB_SUFFIX)
	@if not exist $(PREFIX)\share\vala\vapi\ mkdir $(PREFIX)\share\vala\vapi
	@if not exist $(PREFIX)\share\vala$(LIB_SUFFIX)\vapi\ mkdir $(PREFIX)\share\vala$(LIB_SUFFIX)\vapi
	@for %%s in (valac vapigen) do @for %%x in (exe pdb) do @copy /b vs$(VSVER)\$(CFG)\$(PLAT)\%%s.%%x $(PREFIX)\bin
	@for %%s in (vala$(LIB_SUFFIX) valaccodegen) do @for %%x in (dll pdb) do @copy /b vs$(VSVER)\$(CFG)\$(PLAT)\%%s.%%x $(PREFIX)\bin
	@copy /b vs$(VSVER)\$(CFG)\$(PLAT)\vala$(LIB_SUFFIX).lib $(PREFIX)\lib
	@for %%h in ($(LIBGEE_HEADER) $(LIBVALA_HEADER)) do @copy %%h $(PREFIX)\include\vala$(LIB_SUFFIX)
	@for %%s in (gen-introspect) do @for %%x in (exe dll pdb) do @if exist vs$(VSVER)\$(CFG)\$(PLAT)\%%s.%%x copy /b vs$(VSVER)\$(CFG)\$(PLAT)\%%s.%%x $(PREFIX)\lib\vala$(LIB_SUFFIX)
	@for %%x in (vapi deps) do @copy /b ..\vapi\*.%x $(PREFIX)\share\vala$(LIB_SUFFIX)\vapi
	@copy /b $(VALA_VAPI) $(PREFIX)\share\vala\vapi
