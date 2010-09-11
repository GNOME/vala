VALA_AUX = $(DIRECTORY).vala-aux/

.PHONY: all-vapi

BASENAMES = $(notdir $(basename $(VALAFILES)))
VALA_FASTVAPI_FILES = $(foreach f, $(BASENAMES), $(VALA_AUX)$(f).vapi)
VALA_FASTVAPI_STAMPS = $(foreach f, $(BASENAMES), $(VALA_AUX)$(f).vapi.stamp)
VALA_DEPS = $(foreach f, $(BASENAMES), $(VALA_AUX)$(f).dep)

all: $(VALA_DEPS) $(OUT_HFILE)

.PRECIOUS: $(VALA_AUX)%.vapi.stamp $(VALA_AUX)%.dep

$(VALA_AUX)%.vapi: ;

$(VALA_AUX)%.vapi.stamp: $(DIRECTORY)%.vala | $(VALA_AUX)
	@echo '  GEN    '$(@:.stamp=); $(VALAC) --fast-vapi=$(@:.stamp=) $< && touch $@

$(VALA_AUX)%.dep: $(DIRECTORY)%.vala | $(VALA_FASTVAPI_STAMPS)
	@echo '  GEN    '$(<:.vala=.c); $(VALAC) -C --deps=$@ $(VALAFLAGS) $(addprefix --use-fast-vapi=,$(subst $(VALA_AUX)$(notdir $(basename $@)).vapi,, $(VALA_FASTVAPI_FILES))) $<

$(VALA_AUX):
	@mkdir -p $(VALA_AUX)

include $(wildcard $(VALA_AUX)/*.dep)

ifdef OUT_HFILE
$(OUT_HFILE) $(addsuffix .vapi,$(OUT_VAPI)): $(VALA_FASTVAPI_FILES) | $(VALA_FASTVAPI_STAMPS)
	@echo '  GEN    '$(OUT_HFILE) $(addsuffix .vapi,$(OUT_VAPI)); $(VALAC) -C -H $(OUT_HFILE) $(addprefix --library=,$(OUT_VAPI)) $(VALAFLAGS) $(addprefix --use-fast-vapi=,$(VALA_FASTVAPI_FILES)) && touch $(OUT_HFILE)
endif
