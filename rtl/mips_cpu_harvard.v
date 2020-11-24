module mips_cpu_harvard(
    /* Standard signals */
    input logic     clk,
    input logic     reset,
    output logic    active,
    output logic [31:0] register_v0,

    /* New clock enable. See below. */
    input logic     clk_enable,

    /* Combinatorial read access to instructions */
    output logic[31:0]  instr_address,
    input logic[31:0]   instr_readdata,

    /* Combinatorial read and single-cycle write access to instructions */
    output logic[31:0]  data_address,
    output logic        data_write,
    output logic        data_read,
    output logic[31:0]  data_writedata,
    input logic[31:0]  data_readdata
);


always_ff @(posedge clk) begin
    if (reset) then begin
        /* Do reset logic */
        my_ff <= ... ;
    end
    else if(clk_enable) then
        /* Perform clock update */
        m_ff <= ... ;
    end
end

logic [32][0:31] internal registers; //defining the registers used inside the MIPS CPU