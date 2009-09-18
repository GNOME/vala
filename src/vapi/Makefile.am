NULL =

vapidir = $(datadir)/vala/vapi

valadoc-1.0.vapi: ../libvaladoc/valadoc-1.0.vapi
	cat ../libvaladoc/valadoc-1.0.vapi > valadoc-1.0.vapi

dist_vapi_DATA =     \
	valadoc-1.0.vapi \
	valadoc-1.0.deps \
	$(NULL)

dist_noinst_DATA = \
	$(NULL)

MAINTAINERCLEANFILES = \
	valadoc-1.0.vapi \
	$(NULL)

