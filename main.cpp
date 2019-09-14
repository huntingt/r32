#include "VR32.h"
#include "verilated.h"
#include <string>
#include <stdexcept>

void cycle(VR32* modulee, int times);

int main(int argc, char** argv, char ** env) {
    Verilated::commandArgs(argc, argv);
    VR32* top = new VR32();

    top->reset = 1;
    cycle(top, 1);

    top->reset = 0;
    
    for (int i = 0; i < 100; i++) {
        if (top->m_address != i) {
            std::runtime_error("expected " + std::to_string(i) + ", got " + std::to_string(top->m_address));
        }
        cycle(top, 1);
    }

    delete top;
    printf("passed!\n");
    exit(0);
}

/*
 * Advances the clock by times cycles
 */
void cycle(VR32* module, int times) {
    module->clock = 0;
    module->eval();

    module->clock = 1;
    module->eval();
}
