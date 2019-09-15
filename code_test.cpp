#include "code_test.h"

/*
 * Initializes a new test that takes in a binary riscv
 * file and then executes it on the module. The module
 * then passes if the "passed" value is written into the
 * "passed_address" location
 */
CodeTest::CodeTest(std::string file, uint32_t base_address, uint32_t length) {
    top = new VR32();
    
    MemoryInterface iBus{
        .m_address = &top->im_address,
        .m_data = &top->im_data,
        .m_write = &top->im_write,
        .m_ready = &top->im_ready,
        .m_valid = &top->im_valid,
        .s_data = &top->is_data,
        .s_ready = &top->is_ready,
        .s_valid = &top->is_valid
    };

    MemoryInterface dBus{
        .m_address = &top->dm_address,
        .m_data = &top->dm_data,
        .m_write = &top->dm_write,
        .m_ready = &top->dm_ready,
        .m_valid = &top->dm_valid,
        .s_data = &top->ds_data,
        .s_ready = &top->ds_ready,
        .s_valid = &top->ds_valid
    };

    imemory = new MemoryController(base_address, length, iBus);
    imemory->loadBinary(file);

    dmemory = new MemoryController(0, 2048, dBus);
}

/*
 * Runs the test with a given timeout
 * @param: timeout the maximum number of cycles that the test
 *      can run before timing out
 * @return: whether or not the test passed
 */
std::tuple<bool, std::string> CodeTest::run(int timeout) {
    utils::reset(top);
    imemory->init();
    dmemory->init();

    for (int i = 0; i < timeout; i++) {
        // check for finish
        if (top->dm_ready && top->dm_valid) {
            if (top->dm_address == passed_address) {
                if (top->dm_data == passed) {
                    return std::make_tuple(true, \
                        "passed after " + std::to_string(i) + " cycles");
                } else {
                    return std::make_tuple(false, \
                        "failed with " + std::to_string(top->dm_data) + " code errors");
                }
            }
        }

        auto iresult = imemory->clock();
        if (!std::get<0>(iresult)) return iresult;

        auto dresult = dmemory->clock();
        if (!std::get<0>(dresult)) return dresult;
        
        utils::clock(top, 1);
    }

    return std::make_tuple(false, \
            "timed out after " + std::to_string(timeout) + " cycles");
}

CodeTest::~CodeTest() {
    delete this->top;
    delete this->imemory;
    delete this->dmemory;
}
