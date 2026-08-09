TOP = carry_skip

RTL_DIR = rtl
TB_DIR  = tb

RTL = ../full_adder/rtl/full_adder.sv \
      rtl/carry_skip.sv
TB = $(TB_DIR)/$(TOP)_tb.sv

build:
	verilator --binary --trace \
	--top-module carry_skip_tb \
	../full_adder/rtl/full_adder.sv \
	rtl/carry_skip.sv \
	tb/carry_skip_tb.sv

run: build
	./obj_dir/Vcarry_skip_tb

wave: run
	surfer $(TOP).vcd

clean:
	rm -rf obj_dir *.vcd *.log

all: run