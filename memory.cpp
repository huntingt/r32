#include "memory.h"

MemoryController::MemoryController(uint32_t base_address, uint32_t length, MemoryInterface slave){
    this->base_address = base_address;
    this->length = length;
    this->slave = slave;

    this->memory = new uint32_t[length];
}

/*
 * Load a binary file into the memory starting at the base
 * address.
 */
void MemoryController::loadBinary(std::string file){
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
 * Initialize memory controller by getting ready and
 * setting data to invalid
 */
void MemoryController::init(){
    *slave.m_ready = true;
    *slave.s_valid = false;
}

/*
 * Iterate the interface for a clock cycle
 * @return whether or not it succeed for the cycle or failed
 */
std::tuple<bool, std::string> MemoryController::clock(){
    //TODO:Implement queue
    // if the output was consumed last cycle
    if (*slave.s_valid && *slave.s_ready) {
        *slave.s_valid = false;
    }

    // check for input
    if (*slave.m_valid && *slave.m_ready) {
        *slave.s_valid = true;
        
        if (*slave.m_address % 4 != 0) {
            return std::make_tuple(false, \
                "unaligned addressing not supported " + std::to_string(*slave.m_address));
        }

        int index = (*slave.m_address - base_address) / 4;
        if (index < 0 || index >= length) {
            return std::make_tuple(false, \
                "memory out of bounds " + std::to_string(*slave.m_address));
        }

        if (*slave.m_write) {
            memory[index] = *slave.m_data;
        } else {    
            *slave.s_data = memory[index];
        }
    }

    // if the register can't hold another value, then wait
    *slave.m_ready = !*slave.s_valid;

    return std::make_tuple(true, "");
}

MemoryController::~MemoryController(){
    delete memory;    
}
