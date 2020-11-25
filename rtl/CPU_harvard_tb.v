module CPU_harvard_tb;
    timeunit 1ns/ 10ps;

    parameter TIMEOUT_CYCLES = 10000;

    logic clk;
    logic rst;

    logic active;

    logic [31:0] register_v0;

    logic clk_en;

    logic [31:0] instr_address;
    logic[31:0] instr_readdata;

    logic[31:0] data_address;
    logic data_write;
    logic data_read;
    logic[31:0] data_writedata;
    logic[31:0] data_readdata;

    mips_cpu_harvard cpuInst(clk,rst,active,register_v0,clk_en,instr_address,instr_readdata,data_address,data_write,data_read,data_writedata,data_readdata);
    ADDRESS_RAM_32x32_HARVARD ram1Inst(instr_address,instr_readdata);
    DATA_RAM_32x32_HARVARD ram2Inst(clk,data_address,data_writedata,data_readdata,data_write,data_read);

    // Generate clock
    initial begin;
        $dumpfile("CPU_harvard_tb.vcd");
        $dumpvars(0,CPU_harvard_tb);

        clk = 0;
        clk_en = 0;
        repeat (TIMEOUT_CYCLES)begin
            #10;
            clk = !clk;
            clk_en = 1;
            #10;
            clk_en = 0;
            clk = !clk;
        end


        $fatal(2, "Simulation did not finish within the %d cycles.", TIMEOUT_CYCLES);
    end
    
    initial begin
        rst <= 0;

        @(posedge clk);
        rst <= 1;

        @(posedge clk);
        rst <= 0;

        @(posedge clk);
        assert(active==1)
        else $display("TB: CPU did not set active = 1 after reset.");

        while (active) begin
            @(posedge clk);
        end

        $display("TB : finished; active=0");

        $finish;
    end
endmodule