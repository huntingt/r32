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

    function void init();
        m_valid <= 0;
        s_ready <= 0;
    endfunction

    /*
     * Checks to see if the memory bus is ready
     */
    function logic ready();
        // either mot occupied or the transaction will be completed
        ready = !m_valid || m_ready;
    endfunction

    function void store(logic [31:0] address, logic [31:0] data);
        m_address <= address;
        m_data <= data;
        m_write <= 1;
        m_valid <= 1;
    endfunction

    function void load(logic [31:0] address);
        m_address <= address;
        m_write <= 0;
        m_valid <= 1;
    endfunction

    /*
     * This function should be run whenever the bus is not in use
     */
    function void nop();
        m_valid <= 0;
    endfunction

    function logic readable();
        readable = s_ready && s_valid;
    endfunction

    function logic [31:0] read();
        read = s_data;
    endfunction

    modport master(
        import init,
        import ready,
        import store,
        import load,
        import nop,
        import readable,
        import read,

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
