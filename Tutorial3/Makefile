SHELL := /bin/bash
.ONESHELL:

PROJECT_ROOT := $(abspath $(CURDIR)/../..)
RTL := $(PROJECT_ROOT)/rtl

imem_tb: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv \
		$(PROJECT_ROOT)/tutorial1/imem_tb.sv \
		$(PROJECT_ROOT)/tutorial1/imem.sv
	vsim -c work.imem_tb -do "run -all; quit -f;"

cpu_v01: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog +cover -sv $(PROJECT_ROOT)/tutorial1/cpu_tb.sv \
	    $(PROJECT_ROOT)/tutorial1/cpu.sv \
	    $(PROJECT_ROOT)/tutorial1/alu.sv \
	    $(PROJECT_ROOT)/tutorial1/imem.sv 

	vsim -sv_seed 100 -c -coverage work.cpu_tb -do "coverage save -onexit coverage.ucdb; run -all; quit -f;"

# single-cycle riscv cpu
cpu: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv $(RTL)/cpu_tb.sv $(RTL)/cpu.sv $(RTL)/alu.sv
	vsim -c work.cpu_tb -do "run -all; quit -f;"

# sudoku
sudoku: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv $(PROJECT_ROOT)/examples/sudoku_solver.sv
	vsim -c work.sudoku_solver -do "run -all; quit -f;"

# gaussian
gaussian: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv $(PROJECT_ROOT)/examples/dist_gaussian.sv
	vsim -c work.dist_gaussian -do "run -all; quit -f;"

# tstudent
tstudent: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv $(PROJECT_ROOT)/examples/dist_t_student.sv
	vsim -c work.dist_t_student -do "run -all; quit -f;"

# chisquare
chisquare: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv $(PROJECT_ROOT)/examples/dist_chi_square.sv
	vsim -c work.dist_chi_square -do "run -all; quit -f;"

# tutorial 3
cpu_tutorial3: clean
	source $(PROJECT_ROOT)/tools/questa/setup.sh
	vlib work
	vmap work work
	vlog -sv \
		$(PROJECT_ROOT)/rtl/cpu.sv \
		$(PROJECT_ROOT)/rtl/alu.sv \
		$(PROJECT_ROOT)/uvm/cpu_pkg.sv \
		$(PROJECT_ROOT)/uvm/cpu_bfm.sv \
		$(PROJECT_ROOT)/uvm/top.sv \
		+incdir+$(PROJECT_ROOT)/uvm/uvm_classes
	vopt top -o top_optimized +cover=sbfec+cpu
	vsim -c +UVM_TESTNAME="random_test" top_optimized -coverage -do "set NoQuitOnFinish 1; onbreak {resume}; log /* -r; run -all; coverage save -onexit coverage.ucdb; quit;"
	vcover report coverage.ucdb
	vsim -sv_seed random -c +UVM_TESTNAME="add_test" top_optimized -coverage -do "set NoQuitOnFinish 1; onbreak {resume}; log /* -r; run -all; coverage save -onexit coverage.ucdb; quit;"
	vcover report coverage.ucdb

# clean: removes output files
clean:
	rm ./vsim.wlf -f
	rm ./vsim.dbg -f
	rm ./modelsim.ini -f
	rm ./coverage.ucdb -f
	rm ./coverage.txt -f
	rm ./work/ -rf
	rm ./transcript -f


