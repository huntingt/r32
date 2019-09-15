package Decode; 
    typedef enum {
        LUI,
        AUIPC,
        JAL,
        JALR,
        BEQ,
        BNE,
        BLT,
        BGE,
        BLTU,
        BGEU,
        LW,
        SW,
        ADDI,
        SLTI,
        SLTIU,
        XORI,
        ORI,
        ANDI,
        SLLI,
        SRLI,
        SRAI,
        ADD,
        SUB,
        SLL,
        SLT,
        SLTU,
        XOR,
        SRL,
        SRA,
        OR,
        AND
    } Opcode;
    
    typedef struct packed{
        logic [31:0] imm;
        logic [4:0] rs1, rs2, rd;
        logic rs1_v, rs2_v, rd_v;
        Opcode opcode;
    } Dec;

    /*
     * Performs actual decoding operation into struct
     */
    function Dec decode(logic [31:0] inst);
        /* verilator lint_off UNUSED */
        logic [6:0] opcode = inst[6:0];

        logic [6:0] funct7 = inst[31:25];
        logic [2:0] funct3 = inst[14:12];

        logic [31:0] immI;
        logic [31:0] immS;
        logic [31:0] immB;
        logic [31:0] immU;
        logic [31:0] immJ;
        
        logic f7all0 = funct7 == 'b0000000;
        logic f7one0 = funct7 == 'b0100000;

        logic [4:0] rd, rs1, rs2;
        rd = inst[11:7];
        rs1 = inst[19:15];
        rs2 = inst[24:20];
        
        immI = {{21{inst[31]}}, inst[30:25], inst[24:21], inst[20]};
        immS = {{21{inst[31]}} , inst[30:25],  inst[11:8],  inst[7]};
        immB = {{20{inst[31]}}, inst[7], inst[30:25],  inst[11:8],     1'b0};
        immU = {{ 1{inst[31]}}, inst[30:20], inst[19:12], 12'b0};
        immJ = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0};
        
        case (opcode)
            7'b0110111: decode = '{opcode: LUI, rd_v:1,rs1_v:0,rs2_v:0, rd: rd, imm: immU, default: 'x};
            7'b0010111: decode = '{opcode: AUIPC, rd_v:1,rs1_v:0,rs2_v:0,rd: rd, imm: immU, default: 'x};
            7'b1101111: decode = '{opcode: JAL, rd_v:1,rs1_v:0,rs2_v:0,  rd: rd, imm: immJ, default: 'x};
            default   : begin
                //$display("unrecognized opcode");
                decode = '{default:'x};
            end
        endcase
        /* verilator lint_on UNUSED */
    endfunction
endpackage
