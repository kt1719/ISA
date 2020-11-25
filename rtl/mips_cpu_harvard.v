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

    typedef enum logic [5:0]{
        OPCODE_LW = 5'b100011
    } opcode_t

    typedef enum logic[1:0] {
        FETCH = 2'b00
        EXEC = 2'b01
        WRITE_BACK = 2'b10
        HALT = 2'b11
    } state_t

    logic [1:0] state;

    logic [32][31:0] intern_reg; //defining the registers used inside the MIPS CPU
    wire[31:0] register_source, register_destination;
    logic[31:0] pc;

    wire[31:0] pc_increment;
    pc_increment = pc +1;

    logic[4:0] register_addr;
    opcode_t instr_opcode;
    logic[4:0] register_dest;
    logic[15:0] immediate;
    logic[31:0] instr;
    logic[31:0] ALU_sum;

    assign instr_address = pc;

    assign register_addr = instr[25:21];
    assign instr_opcode = instr[31:26];
    assign register_dest = instr[20:16];
    assign immediate = instr[15:0];
    assign instr_address = instr_address_out


    assign register_source = (instr_opcode == OPCODE_LW)? intern_reg[register_addr] : 32'hxxxxxxxx;
    assign register_dest = 


    assign data_address = ALU_sum;

    always_ff @(posedge clk) begin
        if (reset) then begin
            /* Do reset logic */
            pc <= 0;
            for(index = 0; index<32; index = index+1) begin
                intern_reg[index] <= 0;
                state <= FETCH;
            end
        end
        else if (state == FETCH) begin
                instr <= instr_readdata;
                ALU_sum = $signed(immediate) + register_source;
                state <= EXEC;
            end

        else if(clk_enable) then
            /* Perform clock update */
            case(instr_opcode)
                OPCODE_LW: begin
                    intern_reg[register_dest] <= data_readdata;
                    pc <= pc_increment;
                    state <= FETCH;
        end
    end