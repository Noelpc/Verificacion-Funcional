`timescale 1ns/1ps

module top();

    // import uvm package and macros
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // import cpu package and macros
    import cpu_pkg::*;
    `include "cpu_macros.svh"

    // instantiate dut and bfm
    cpu DUT (
        .rst     (bfm.rst),
        .clk     (bfm.clk),
        .PC      (bfm.pc),
        .Instr   (bfm.instr),
        .Result  (bfm.result)
    );

    cpu_bfm bfm();

    initial begin
        
        // use the set() method from uvm_config_db to store the bfm into the config database
        uvm_config_db #(virtual cpu_bfm)::set(null, "*", "bfm", bfm);

        // run the test
        run_test();

    end

endmodule

