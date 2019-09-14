#include <iostream>
#include <string>

#include "verilated.h"
#include "code_test.h"

int main(int argc, char** argv, char ** env) { 
    //setup verilator
    Verilated::commandArgs(argc, argv);
    
    std::cout << "Starting test bench" << std::endl;
    
    CodeTest tb = CodeTest("test/bin/simple.bin", 0x200, 0x2000);
    tb.run(1);

    return 0;
}
