
# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)
export LIBPYTHON_LOC=$(shell cocotb-config --libpython)

test_dflop:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s dflop -s dump -g2012 src/dflop.v test/dump_dflop.v 
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_dflop vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp -vcd
	! grep failure results.xml

test_shift_reg:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s shift_reg -s dump -g2012 src/shift_reg.v test/dump_shift_reg.v 
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_shift_reg vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp -vcd
	! grep failure results.xml

test_lfsr:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s lfsr -s dump -g2012 src/lfsr.v src/shift_reg.v test/dump_lfsr.v 
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_lfsr vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp -vcd
	! grep failure results.xml

test_tap:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s tap -s dump -g2012 src/tap.v src/shift_reg.v test/dump_tap.v 
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_tap vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp -vcd
	! grep failure results.xml


show_gtk_: %.vcd ./gtkwave_saves/%.gtkw
	gtkwave $^

show_synth_%: src/%.v
	yosys -p "read_verilog $<; proc; opt; show -colors 2 -width -signed"

show_%: %.vcd %.gtkw
	gtkwave $^


