#include "code_test.h"

/*
 * Initializes a new test that takes in a binary riscv
 * file and then executes it on the module. The module
 * then passes if the "passed" value is written into the
 * "passed_address" location
 */

CodeTest::CodeTest(std::string file, uint32_t base_address, uint32_t length) {
    this->base_address = base_address;
    this->length = length;
    
    this->top = new VR32();
    this->memory = new uint32_t[length];
}

bool CodeTest::run(int timeout) {
    for (int i = 0; i < timeout; i++) {
        //TODO: implement simulation logic
    }

    throw std::runtime_error("timed out after " + std::to_string(timeout) + " cycles :/");
}

CodeTest::~CodeTest() {
    delete this->top;
    delete this->memory;
}
