/*
 * top level module for processor
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

    always_ff @(posedge clock) begin
        if (reset) begin
            m_address <= 3;
            m_data <= 0'hAA_AA_AA_AA;
            m_valid <= 1;
            m_write <= 1;

            s_ready <= 1;
        end else if (m_ready) begin
            s_ready <= s_data == 0'hAAAAAAAA || s_valid;
        end
    end
endmodule
