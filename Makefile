#TODO: fix verilator so that it uses SV_DIR
#TODO: change this makefile so that it does all of the dependency tracking for the system verilog
TOP=R32
SV_DIR=obj_dir
INCLUDES=main.cpp code_test.cpp memory.cpp

test: FORCE
	verilator -Wall --cc $(TOP).sv --exe $(INCLUDES) -CFLAGS "-std=c++17"
	make -j -C $(SV_DIR) -f V$(TOP).mk V$(TOP)
	make -C test
	./$(SV_DIR)/V$(TOP)

FORCE:

clean:
	make -C test clean
	rm -rf $(SV_DIR)/
