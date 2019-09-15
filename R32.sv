/*
 * convert from the interfaces
 */
module R32(
    clock,
    reset,

    im_address,
    im_data,
    im_write,
    im_ready,
    im_valid,

    is_data,
    is_ready,
    is_valid,

    dm_address,
    dm_data,
    dm_write,
    dm_ready,
    dm_valid,

    ds_data,
    ds_ready,
    ds_valid
    );

    input clock;
    input reset;

    output logic [31:0] im_address;
    output logic [31:0] im_data;
    output logic        im_write;
    input               im_ready;
    output logic        im_valid;
    
    input        [31:0] is_data;
    output logic        is_ready;
    input               is_valid;

    output logic [31:0] dm_address;
    output logic [31:0] dm_data;
    output logic        dm_write;
    input               dm_ready;
    output logic        dm_valid;
    
    input        [31:0] ds_data;
    output logic        ds_ready;
    input               ds_valid;

    Memory imemory;
    Memory dmemory;

    assign im_address =  imemory.m_address;
    assign im_data =     imemory.m_data;
    assign im_write =    imemory.m_write;
    assign imemory.m_ready = im_ready;
    assign im_valid =    imemory.m_valid;

    assign imemory.s_data = is_data;
    assign is_ready = imemory.s_ready;
    assign imemory.s_valid = is_valid;

    assign dm_address =  dmemory.m_address;
    assign dm_data =     dmemory.m_data;
    assign dm_write =    dmemory.m_write;
    assign dmemory.m_ready = dm_ready;
    assign dm_valid =    dmemory.m_valid;

    assign dmemory.s_data = ds_data;
    assign ds_ready = dmemory.s_ready;
    assign dmemory.s_valid = ds_valid;

    Core core(
        .clock(clock),
        .reset(reset),
        .instructionBus(imemory.master),
        .dataBus(dmemory.master)
    );
endmodule
