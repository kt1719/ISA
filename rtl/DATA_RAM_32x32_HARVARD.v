module DATA_RAM_32x32_HARVARD(
    input logic clk,
    input logic[31:0] address,
    input logic[31:0] writedata,
    output logic[31:0] readdata,
    input logic write_en,
    input logic read_en
);


    reg[128][7:0] memory;

    initial begin
        integer i;
        /* Initialise to zero by default */
        for (i=0; i<127; i++) begin
            memory[i]=0;
        end
        
    end

    /* Combinatorial read path. */
    assign readdata = read_en ? {memory[address],memory[address+1],memory[address+2],memory[address+3]} : 32'hxxxxxxxx;

        /* Synchronous write path */
    always @(posedge clk) begin
        //$display("RAM : INFO : read=%h, addr = %h, mem=%h", read, address, memory[address]);
        if (write_en) begin
            memory[address] <= writedata[31:24];
            memory[address+1] <= writedata[23:16];
            memory[address+2] <= writedata[15:8];
            memory[address+3] <= writedata[7:0];
        end
    end

endmodule
