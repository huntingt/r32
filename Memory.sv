/*
 * Memory interface and associated tasks and functions
 */
interface Memory;
    logic [31:0] m_address;
    logic [31:0] m_data;
    logic        m_write;
    logic        m_ready;
    logic        m_valid;

    logic [31:0] s_data;
    logic        s_ready;
    logic        s_valid;

    modport master(
        output m_address,
        output m_data,
        output m_write,
        input  m_ready,
        output m_valid,

        input  s_data,
        output s_ready,
        input  s_valid);

    modport slave(
        input  m_address,
        input  m_data,
        input  m_write,
        output m_ready,
        input  m_valid,

        output s_data,
        input  s_ready,
        output s_valid);
endinterface
