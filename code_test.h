#ifndef H_RISCV_TEST
#define H_RISCV_TEST

#include <string>
#include <iostream>
#include <tuple>
#include "VR32.h"
#include "utils.h"
#include "memory.h"

const uint32_t passed = 0xAAAAAAAA;
const uint32_t passed_address = -1;

class CodeTest {
    public:
    CodeTest(std::string file, uint32_t base_address, uint32_t length);

    std::tuple<bool, std::string> run(int timeout);

    ~CodeTest();

    private:    
    VR32* top;

    MemoryController* imemory;
    MemoryController* dmemory;
};

#endif
