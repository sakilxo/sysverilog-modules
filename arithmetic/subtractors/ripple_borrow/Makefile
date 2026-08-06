TOP = ripple_borrow

RTL_DIR = rtl
TB_DIR  = tb

RTL = ../full_subtractor/rtl/full_subtractor.sv \
      rtl/ripple_borrow.sv
TB = $(TB_DIR)/$(TOP)_tb.sv

build:
	verilator --binary --trace \
	--top-module ripple_borrow_tb \
	../full_subtractor/rtl/full_subtractor.sv \
	rtl/ripple_borrow.sv \
	tb/ripple_borrow_tb.sv

run: build
	./obj_dir/Vripple_borrow_tb

wave: run
	surfer $(TOP).vcd

clean:
	rm -rf obj_dir *.vcd *.log

all: run