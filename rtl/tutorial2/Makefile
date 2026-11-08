SHELL := /bin/bash
.ONESHELL:

PROJECT_ROOT := .

cpu: 
	source $(PROJECT_ROOT)/setup.sh
	vlib work
	vmap work work
	vlog -sv -f $(PROJECT_ROOT)/dut.f
	vlog -sv -f $(PROJECT_ROOT)/tb.f
	vopt top -o top_optimized +cover=sbfec
	vsim -sv_seed random -c top_optimized -coverage -do "set NoQuitOnFinish 1; onbreak {resume}; log /* -r; run -all; coverage save -onexit coverage.ucdb; quit;"
	#vcover report coverage.ucdb
