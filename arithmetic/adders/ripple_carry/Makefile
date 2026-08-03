TOP = ripple_carry

RTL_DIR = rtl
TB_DIR  = tb

RTL = ../full_adder/rtl/full_adder.sv \
      rtl/ripple_carry.sv
TB = $(TB_DIR)/$(TOP)_tb.sv

build:
	verilator --binary --trace \
	--top-module ripple_carry_tb \
	../full_adder/rtl/full_adder.sv \
	rtl/ripple_carry.sv \
	tb/ripple_carry_tb.sv

run: build
	./obj_dir/Vripple_carry_tb

wave: run
	surfer $(TOP).vcd

clean:
	rm -rf obj_dir *.vcd *.log

all: run