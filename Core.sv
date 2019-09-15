/*
 * top level module for processor
 */
module Core(
    clock,
    reset,
    instructionBus,
    dataBus
    );

    input clock;
    input reset;

    Memory.master instructionBus;
    Memory.master dataBus;

    logic [31:0] pc;
    
    always_ff @(posedge clock) begin
        if (reset) begin
            instructionBus.init();
            dataBus.init();
            
            pc <= 0'h200;
        end else begin
            // fetch
            if (instructionBus.ready()) begin
                instructionBus.load(pc);
                pc <= pc + 4;
            end

            instructionBus.s_ready <= 1;
            if (instructionBus.readable()) begin
                $display(instructionBus.read());
            end

            //dataBus.store(-1, 0'hAA_AA_AA_AA);
            dataBus.s_ready <= dataBus.s_data == 0'hAAAAAAAA || dataBus.s_valid;
        end
    end
endmodule
