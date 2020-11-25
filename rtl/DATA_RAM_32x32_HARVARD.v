module DATA_RAM_32x32_HARVARD(
    input logic[31:0] address,
    input logic[31:0] writedata,
    output logic[31:0] readdata,
    input logic write_en,
    input logic read_en
);
    parameter RAM_INIT_FILE = "";

    reg[2147483647][31:0] memory;

    initial begin
        integer i;
        /* Initialise to zero by default */
        for (i=0; i<2147483646; i++) begin
            memory[i]=0;
        end
        /* Load contents from file if specified */
        if (RAM_INIT_FILE != "") begin
            $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemh(RAM_INIT_FILE, memory);
        end
    end

    /* Combinatorial read path. */
    assign readdata = read ? memory[address] : 32'hxxxxxxxx;

        /* Synchronous write path */
    always @(posedge clk) begin
        //$display("RAM : INFO : read=%h, addr = %h, mem=%h", read, address, memory[address]);
        if (write) begin
            memory[address] <= writedata;
        end
    end

endmodule
