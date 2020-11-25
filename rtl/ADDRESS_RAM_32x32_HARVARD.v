module ADDRESS_RAM_32x32_HARVARD(
    input logic[31:0] address,
    output logic[31:0] readdata
);

    reg[32][31:0] memory;

    initial begin
        integer i;
        /* Initialise to zero by default */
        for (i=0; i<31; i++) begin
            memory[i]=0;
        end
        memory[0] = 32'h8C220000;
        memory[1] = 32'hFFFFFFFF;
    end

    /* Combinatorial read path. */
    assign readdata = memory[address];

endmodule
