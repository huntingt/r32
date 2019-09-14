/*
 * convert from the interfaces
 */
module R32(
    clock,
    reset,

    m_address,
    m_data,
    m_write,
    m_ready,
    m_valid,

    s_data,
    s_ready,
    s_valid
    );

    input clock;
    input reset;

    output logic [31:0] m_address;
    output logic [31:0] m_data;
    output logic        m_write;
    input               m_ready;
    output logic        m_valid;
    
    input        [31:0] s_data;
    output logic        s_ready;
    input               s_valid;

    Memory memory;

    assign m_address = memory.m_address;
    assign m_data = memory.m_data;
    assign m_write = memory.m_write;
    assign memory.m_ready = m_ready;
    assign m_valid = memory.m_valid;

    assign memory.s_data = s_data;
    assign s_ready = memory.s_ready;
    assign memory.s_valid = s_valid;

    Core core(
        .clock(clock),
        .reset(reset),
        .memory(memory.master)
    );
endmodule
