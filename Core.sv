/*
 * top level module for processor
 */
module Core(
    clock,
    reset,
    memory
    );

    input clock;
    input reset;

    Memory.master memory;

    always_ff @(posedge clock) begin
        if (reset) begin
            memory.m_address <= -1;
            memory.m_data <= 0'hAA_AA_AA_AA;
            memory.m_valid <= 1;
            memory.m_write <= 1;

            memory.s_ready <= 1;
        end else if (memory.m_ready) begin
            memory.s_ready <= memory.s_data == 0'hAAAAAAAA || memory.s_valid;
        end
    end
endmodule
