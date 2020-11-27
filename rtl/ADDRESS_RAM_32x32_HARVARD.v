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
        memory[0] = 8'h00;
        memory[1] = 8'h20;
        memory[2] = 8'h00;
        memory[3] = 8'h08;

        memory[4] = 8'h00;
        memory[5] = 8'h00;
        memory[6] = 8'h00;
        memory[7] = 8'h00;


    end

    /* Combinatorial read path. */
    assign readdata = {memory[address],memory[address+1],memory[address+2],memory[address+3]};

endmodule
