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

    typedef enum logic[5:0] {
        OPCODE_LW = 6'b100011,
        OPCODE_SW = 6'b101011,
        OPCODE_STP = 6'b111111
    } opcode_t;

    logic [31:0] intern_reg [31:0]; 
    wire[31:0] register_source, register_destination;
    logic[31:0] pc;

    wire[31:0] pc_increment;
    assign pc_increment = pc +4;

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

    assign register_source = (instr_opcode == OPCODE_LW)? intern_reg[register_addr] : (instr_opcode == OPCODE_SW) ? intern_reg[register_addr] : 32'hxxxxxxxx;
    assign register_v0 = intern_reg[3];

    assign instr = instr_readdata;
    assign ALU_sum = $signed(immediate) + register_source;

    assign data_address = ALU_sum;

    assign data_read = (instr_opcode == OPCODE_LW) ? 1 : 0;
    assign data_write = (instr_opcode == OPCODE_SW) ? 1 : 0;
    assign data_writedata = (instr_opcode == OPCODE_SW) ? intern_reg[register_dest] : 8'hxxxxxxxx;


    initial begin 
        active = 0;
    end

    integer index;
    always_ff @(posedge clk) begin
        if (reset) begin
            /* Do reset logic */
            pc <= 0;
            active = 1;
            for(index = 0; index<32; index = index+1) begin
                intern_reg[index] <= 0;
            end
            intern_reg[1] <= 32'h55509F9F;
        end
        else if(clk_enable) begin
            /* Perform clock update */
            case(instr_opcode)
                OPCODE_LW: begin
                    intern_reg[register_dest] <= data_readdata;
                    pc <= pc_increment;
                end
                OPCODE_STP: begin
                    active <= 0;
                end
                OPCODE_SW: begin;
                    pc <= pc_increment;
                end
            endcase
        end
    end
endmodule