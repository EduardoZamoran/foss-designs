# Makefile común de simulación. Uso desde projects/<cat>/<proy>/sim:
#   make run | make check | make wave | make clean
# Variables opcionales (se definen en el Makefile del proyecto, ANTES del include):
#   PASS_MSG  texto que el testbench imprime al pasar (lo usa "make check")
#   TB_TOP    nombre del testbench top si hay varios módulos top
SHELL        := /bin/bash
.SHELLFLAGS := -o pipefail -c

PROJ    := $(notdir $(abspath ..))
RTL     := $(wildcard ../rtl/*.sv ../rtl/*.v)
TB      := $(wildcard ../tb/*.sv)
BUILD   := build
TB_TOP  ?=
PASS_MSG ?=

all: run

$(BUILD)/$(PROJ).vvp: $(RTL) $(TB)
	mkdir -p $(BUILD)
	iverilog -g2012 $(if $(TB_TOP),-s $(TB_TOP)) -o $@ $(RTL) $(TB)

run: $(BUILD)/$(PROJ).vvp
	cd $(BUILD) && vvp $(PROJ).vvp | tee run.log

check: run
	@if [ -n "$(PASS_MSG)" ]; then \
	  if grep -q "$(PASS_MSG)" $(BUILD)/run.log; then echo "CHECK OK: $(PROJ)"; \
	  else echo "CHECK FAILED: '$(PASS_MSG)' no aparece"; exit 1; fi; \
	fi

wave: run
	gtkwave $$(ls -t $(BUILD)/*.vcd | head -1) &

clean:
	rm -rf $(BUILD)

.PHONY: all run check wave clean
