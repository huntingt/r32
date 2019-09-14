interface Memory;
    logic [32:0] m_address;
    logic [32:0] m_data;
    logic        m_ready;
    logic        m_valid;
    
    logic [32:0] s_data;
    logic        s_ready;
    logic        s_valid;

    modport master(
        output m_address,
        output m_data,
        output m_valid,
        input  m_ready,

        input  s_data,
        input  s_valid,
        output s_ready);

    modport slave(
        input  m_address,
        input  m_data,
        input  m_valid,
        output m_ready,

        output s_data,
        output s_valid,
        input  s_ready);
endinterface
