#TODO: fix verilator so that it uses SV_DIR
#TODO: change this makefile so that it does all of the dependency tracking for the system verilog
SV_DIR=obj_dir
INCLUDES=main.cpp code_test.cpp

test: FORCE
	verilator -Wall --cc R32.sv --exe $(INCLUDES)
	make -j -C $(SV_DIR) -f VR32.mk VR32
	make -C test
	./$(SV_DIR)/VR32

FORCE:

clean:
	make -C test clean
	rm -rf $(SV_DIR)/
