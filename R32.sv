/*
 * top level module for processor
 */
module R32(
    clock,
    reset,

    m_address,
    m_data,
    m_ready,
    m_valid,

    //s_data,
    s_ready//,
    //s_valid
    );

    input clock;
    input reset;

    output logic [32:0] m_address;
    output logic [32:0] m_data;
    input  logic        m_ready;
    output logic        m_valid;
    
    //input  logic [32:0] s_data;
    output logic        s_ready;
    //input  logic        s_valid;

    always_ff @(posedge clock) begin
        if (reset) begin
            m_address <= 0;
            m_data <= 0;
            m_valid <= 1;

            s_ready <= 1;
        end else if (m_ready) begin
            m_address <= m_address + 1;
        end
    end
endmodule
