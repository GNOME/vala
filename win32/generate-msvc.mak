# NMake Makefile portion for code generation and
# intermediate build directory creation
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.

# Generate valaversion.vala.in
# ....

# Generate the various .vapi files in the sources
!ifdef REGEN_C_SOURCES
$(vala_libgee_gen_c_sources): $(OUTDIR)\gee\gee.vapi

$(OUTDIR)\gee\gee.vapi: $(vala_libgee_real_sources)
	@echo Generating $@ and lib$(@B) C sources and headers...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi --pkg gobject-2.0	\
		-H $(@D)\vala$(@B).h --library $(@B) -b ..\$(@B) -d $(@D) $(vala_libgee_real_sources)

$(vala_libvala_gen_c_sources): $(OUTDIR)\libvala$(LIB_SUFFIX).vapi

$(OUTDIR)\libvala$(LIB_SUFFIX).vapi: $(OUTDIR)\gee\gee.vapi $(OUTDIR)\vala\vala.vapi
	@echo Generating $@...
	@if exist $@ del $@
	@type $**>>$@

$(OUTDIR)\vala\vala.vapi: $(vala_libvala_real_sources) $(OUTDIR)\gee\gee.vapi
	@echo Generating $@ and lib$(@B) C sources and headers...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi --pkg gmodule-2.0 --pkg gobject-2.0	\
		--vapidir $(OUTDIR)\gee --pkg gee --pkg config \
		-H $(@D)\vala.h --library $(@B) -b ..\$(@B) -d $(@D) $(vala_libvala_real_sources)

$(vala_libccode_gen_c_sources): $(OUTDIR)\ccode\ccode.vapi
$(OUTDIR)\ccode\ccode.vapi: $(vala_libccode_real_sources) $(OUTDIR)\gee\gee.vapi $(OUTDIR)\vala\vala.vapi
	@echo Generating $@ and lib$(@B) C sources and headers...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi --pkg gobject-2.0	\
		--vapidir $(OUTDIR)\gee --pkg gee --vapidir $(OUTDIR)\vala --pkg vala --pkg config	\
		-H $(@D)\vala$(@B).h --library $(@B) -b ..\$(@B) -d $(@D) $(vala_libccode_real_sources)

$(vala_libcodegen_gen_c_sources): $(OUTDIR)\codegen\codegen.vapi
$(OUTDIR)\codegen\codegen.vapi: $(vala_libcodegen_real_sources) $(OUTDIR)\ccode\ccode.vapi $(OUTDIR)\gee\gee.vapi $(OUTDIR)\vala\vala.vapi
	@echo Generating $@ and lib$(@B) C sources and headers...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi --pkg gobject-2.0	\
		--vapidir $(OUTDIR)\gee --pkg gee --vapidir $(OUTDIR)\ccode --pkg ccode --vapidir $(OUTDIR)\vala --pkg vala	\
		-H $(@D)\vala$(@B).h --library $(@B) -b ..\$(@B) -d $(@D) $(vala_libcodegen_real_sources)

$(compiler_gen_c_sources): $(compiler_real_sources) $(OUTDIR)\codegen\codegen.vapi $(OUTDIR)\ccode\ccode.vapi $(OUTDIR)\gee\gee.vapi $(OUTDIR)\vala\vala.vapi
	@echo Generating valac C sources...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi --pkg gobject-2.0 \
		--vapidir $(OUTDIR)\gee --pkg gee  --vapidir $(OUTDIR)\ccode --pkg ccode \
		--vapidir $(OUTDIR)\vala --pkg vala --vapidir $(OUTDIR)\codegen --pkg codegen --pkg config	\
		-b ..\compiler -d $(@D) $(compiler_real_sources)

$(vapigen_gen_c_sources): $(vapigen_real_sources) $(OUTDIR)\gee\gee.vapi $(OUTDIR)\vala\vala.vapi
	@echo Generating vapigen sources...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi \
		--vapidir $(OUTDIR)\gee --pkg gee --vapidir $(OUTDIR)\vala --pkg vala	\
		--vapidir ..\gobject-introspection --pkg gidl	\
		-b ..\vapigen -d $(@D) $(vapigen_real_sources)

$(vapicheck_gen_c_sources): $(vapicheck_real_sources) $(OUTDIR)\gee\gee.vapi $(OUTDIR)\vala\vala.vapi
	@echo Generating vapicheck sources...
	@$(VALAC) --disable-version-header -C --vapidir ..\vapi \
		--vapidir $(OUTDIR)\gee --pkg gee --vapidir $(OUTDIR)\vala --pkg vala	\
		--vapidir ..\gobject-introspection --pkg gidl	\
		-b ..\vapigen -d $(@D) $(vapicheck_real_sources)
!endif

# Copy the pre-defined config.h.win32
$(OUTDIR)\librsvg\config.h: config.h.win32
	@if not exist $(@D) $(MAKE) /f Makefile.vc CFG=$(CFG) $(@D)
	@-copy $** $@

# Create the build directories
$(OUTDIR)\librsvg			\
$(OUTDIR)\rsvg-gdk-pixbuf-loader	\
$(OUTDIR)\rsvg-tools			\
$(OUTDIR)\rsvg-tests:
	@-mkdir $@

# Generate listing file for introspection
$(OUTDIR)\librsvg\Rsvg_2_0_gir_list:	\
$(librsvg_real_pub_HDRS)		\
$(librsvg_real_extra_pub_HDRS)		\
$(librsvg_real_SRCS)
	@if exist $@ del $@
	@for %%s in ($(librsvg_real_pub_HDRS) $(librsvg_real_extra_pub_HDRS)) do echo %%s >> $@
	@for %%s in ($(librsvg_real_SRCS)) do @if "%%~xs" == ".c" echo %%s >> $@

