#include "VR32.h"
#include "verilated.h"
#include "utils.h"
#include <string>
#include <stdexcept>

int main(int argc, char** argv, char ** env) {
    Verilated::commandArgs(argc, argv);
    VR32* top = new VR32();

    utils::reset(top);
    
    for (int i = 0; i < 100; i++) {
        if (top->m_address != i) {
            std::runtime_error("failed: expected " + std::to_string(i) + ", got " + std::to_string(top->m_address));
        }
        utils::cycle(top, 1);
    }

    delete top;
    printf("passed!\n");
    exit(0);
}
