#ifndef H_RISCV_TEST
#define H_RISCV_TEST

#include <string>
#include <stdexcept>
#include <iostream>
#include <fstream>
#include <tuple>
#include "VR32.h"
#include "utils.h"

const uint32_t passed = 0xAAAAAAAA;
const uint32_t passed_address = -1;
//const uint32_t typical_length = 0x20000;

class CodeTest {
    public:
    CodeTest(std::string file, uint32_t base_address, uint32_t length);

    std::tuple<bool, std::string> run(int timeout);

    ~CodeTest();

    private:    
    VR32* top;

    uint32_t* memory;
    uint32_t base_address;
    uint32_t length;
};

#endif
