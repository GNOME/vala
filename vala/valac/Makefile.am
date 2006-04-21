NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = parser.h
AM_YFLAGS = -d

bin_PROGRAMS = \
	valac \
	$(NULL)

valac_SOURCES = \
	driver.c \
	parser.y \
	scanner.l \
	context.c \
	generator.c \
	$(NULL)

valac_LDADD = \
	$(GLIB_LIBS) \
	$(NULL)
