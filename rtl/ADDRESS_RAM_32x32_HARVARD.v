module ADDRESS_RAM_32x32_HARVARD(
    input logic[31:0] address,
    output logic[31:0] readdata
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
    assign readdata = memory[address];

endmodule
