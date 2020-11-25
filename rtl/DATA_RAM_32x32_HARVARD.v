module DATA_RAM_32x32_HARVARD(
    input logic clk,
    input logic[31:0] address,
    input logic[31:0] writedata,
    output logic[31:0] readdata,
    input logic write_en,
    input logic read_en
);


    reg[32][31:0] memory;

    initial begin
        integer i;
        /* Initialise to zero by default */
        for (i=0; i<31; i++) begin
            memory[i]=0;
        end
        memory[5] = 32'hAAAA0000;
        
    end

    /* Combinatorial read path. */
    assign readdata = read_en ? memory[address] : 32'hxxxxxxxx;

        /* Synchronous write path */
    always @(posedge clk) begin
        //$display("RAM : INFO : read=%h, addr = %h, mem=%h", read, address, memory[address]);
        if (write_en) begin
            memory[address] <= writedata;
        end
    end

endmodule
