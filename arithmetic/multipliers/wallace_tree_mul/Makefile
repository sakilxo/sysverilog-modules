TOP = wallace_tree_multiplier

RTL_DIR = rtl
TB_DIR  = tb

RTL = ../../adders/full_adder/rtl/full_adder.sv \
      rtl/ripple_borrow.sv
TB = $(TB_DIR)/$(TOP)_tb.sv

build:
	verilator --binary --trace \
	--top-module wallace_tree_multiplier_tb \
	../../adders/full_adder/rtl/full_adder.sv \
	rtl/wallace_tree_multiplier.sv \
	tb/wallace_tree_multiplier_tb.sv

run: build
	./obj_dir/Vwallace_tree_multiplier_tb

wave: run
	surfer $(TOP).vcd

clean:
	rm -rf obj_dir *.vcd *.log

all: run