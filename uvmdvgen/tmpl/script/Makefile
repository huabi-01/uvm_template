### User variables

defines = 
uvm_defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
verbosity = UVM_HIGH
seed = 1
testname =  

dfiles = 
vfiles = 
cfiles = 

com_cmd = -sverilog -full64 -lca -kbd -debug_access+all +vcs_vcdpluson -timescale=1ns/1ns -l comp.log -ntb_opts uvm-1.2 -P  /home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/novas.tab /home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/pli.a ${dfiles} ${vfiles} +define+${uvm_defines}+${defines} 

sim_cmd = -l sim.log +UVM_TESTNAME=${testname} +ntb_random_seed=${seed} +UVM_VERBOSITY=${verbosity}

com:
	vcs ${com_cmd}

sim:
	./simv ${sim_cmd}

verdi:
	verdi \
	+v2k \
	-sverilog \
	-f filelist \
	-nolog \
	-ssf test.fsdb &

sim:
	./simv \
  -ucli -i dump_fsdb_vcs.tcl \
	+ntb_random_seed=${seed} \
	+UVM_TESTNAME=${testname} \
	-l sim.log

rpt_cg:
	urg -dir *.vdb -report cg_report
	@echo "coverage report generated in ./cg_report"

verdi_cg:
	verdi -cov -covdir *.vdb/ &

clean:
	rm -rf *.log csrc simv* *.key *.vpd DVEfiles coverage *.vdb tags nWaveLog sharedMem.dat novas.rc novas.conf INCA_libs verdiLog vfastLog BSSLib.lib++ *.h






