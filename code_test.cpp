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

    std::ifstream program;
    program.open(file);

    int index = 0;
    while(!program.eof())
    {
        if (index >= length) {
            throw std::runtime_error(std::string("program too large for memory @") + std::to_string(index));
        }
        
        uint32_t word;
        program.read(reinterpret_cast<char*>(&word), sizeof(uint32_t));
        this->memory[index] = word;
        index += 1;
    }

    program.close();
}

/*
 * Runs the test with a given timeout
 * @param: timeout the maximum number of cycles that the test
 *      can run before timing out
 * @return: whether or not the test passed
 */
std::tuple<bool, std::string> CodeTest::run(int timeout) {
    utils::reset(top);
    top->m_ready = 1;

    //from slave
    top->s_data = 0;
    top->s_valid = 0;

    //TODO:Implement queue
    for (int i = 0; i < timeout; i++) {
        // if the output was consumed last cycle
        if (top->s_valid && top->s_ready) {
            top->s_valid = false;
        }

        // check for input
        if (top->m_valid && top->m_ready) {
            if(top->m_address == passed_address) {
                if (top->m_data == passed) {
                    return std::make_tuple(true, "passed");
                } else {
                    return std::make_tuple(false, \
                        "failed " + std::to_string(top->m_data) + " code tests");
                }
            }
            
            top->s_valid = true;
            
            if (top->m_address % 4 != 0) {
                return std::make_tuple(false, \
                    "unaligned addressing not supported " + std::to_string(top->m_address));
            }

            int index = (top->m_address - base_address) / 4;
            if (index < 0 || index >= length) {
                return std::make_tuple(false, \
                    "memory out of bounds " + std::to_string(top->m_address));
            }

            if (top->m_write) {
                memory[index] = top->m_data;
            } else {    
                top->s_data = memory[index];
            }
        }

        // if the register can't hold another value, then wait
        top->m_ready = !top->s_valid;
        
        utils::clock(top, 1);
    }

    return std::make_tuple(false, \
            "timed out after " + std::to_string(timeout) + " cycles");
}

CodeTest::~CodeTest() {
    delete this->top;
    delete this->memory;
}
