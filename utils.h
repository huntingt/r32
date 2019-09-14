#ifndef H_UTILS
#define H_UTILS

namespace utils {
    /*
     * Advance a module's clock signal by n cycles
     */
    template <typename T> void clock(T* module, int n) {
        module->clock = 0;
        module->eval();

        module->clock = 1;
        module->eval();
    }

    /*
     * Reset a module using the reset signal
     */
    template <typename T> void reset(T* module) {
        module->reset = 1;
        clock(module, 1);
        module->reset = 0;
    }
}

#endif
