module ADDRESS_RAM_32x32_HARVARD(
    input logic[31:0] address,
    output logic[31:0] readdata
);

    reg[128][7:0] memory;

    initial begin
        integer i;
        /* Initialise to zero by default */
        for (i=0; i<128; i++) begin
            memory[i]=0;
        end
        memory[0] = 8'hAC;
        memory[1] = 8'h41;
        memory[2] = 8'h00;
        memory[3] = 8'h0A;

        memory[4] = 8'h8C;
        memory[5] = 8'h43;
        memory[6] = 8'h00;
        memory[7] = 8'h0A;


    end

    /* Combinatorial read path. */
    assign readdata = {memory[address],memory[address+1],memory[address+2],memory[address+3]};

endmodule
