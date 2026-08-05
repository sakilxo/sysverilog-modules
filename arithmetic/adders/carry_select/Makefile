TOP = carry_select

RTL_DIR = rtl
TB_DIR  = tb

RTL = ../full_adder/rtl/full_adder.sv \
	  ../ripple_carry/rtl/ripple_carry.sv \
      rtl/carry_select.sv
TB = $(TB_DIR)/$(TOP)_tb.sv

build:
	verilator --binary --trace \
	--top-module carry_select_tb \
	../full_adder/rtl/full_adder.sv \
	../ripple_carry/rtl/ripple_carry.sv \
	rtl/carry_select.sv \
	tb/carry_select_tb.sv

run: build
	./obj_dir/Vcarry_select_tb

wave: run
	surfer $(TOP).vcd

clean:
	rm -rf obj_dir *.vcd *.log

all: run