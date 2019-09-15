#ifndef H_MEMORY
#define H_MEMORY

#include <string>
#include <stdexcept>
#include <fstream>
#include <tuple>

struct MemoryInterface{
    uint32_t* m_address;
    uint32_t* m_data;
    uint8_t*  m_write;
    uint8_t*  m_ready;
    uint8_t*  m_valid;

    uint32_t* s_data;
    uint8_t*  s_ready;
    uint8_t*  s_valid;
};

class MemoryController{
    public:
    MemoryController(uint32_t base_address, uint32_t length, MemoryInterface slave);

    void loadBinary(std::string file);

    void init();
    std::tuple<bool, std::string> clock();

    ~MemoryController();

    private:
    MemoryInterface slave;

    uint32_t* memory;
    uint32_t base_address;
    uint32_t length;
};

#endif
