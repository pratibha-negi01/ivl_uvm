////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : sport_go2uvm_top
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////
// Generating Go2UVM top module for DUT: sprot
// ---------------------------------------------------------

`include "uvm_pkg.sv"
`include "G2U_sig_access_test.sv"
`include "sprot_if.sv"
import uvm_pkg::*;
//`include "G2U_sig_access_test.sv"
module sprot_go2uvm;
  parameter VW_CLK_PERIOD = 10;

  // Simple clock generator
  bit clk ;
  always # (VW_CLK_PERIOD/2) clk <= ~clk;

  // Interface instancez
  sprot_if sprot_if_0 (clk);

  // Connect TB clk to Interface instance clk

  // DUT instance
  sprot sprot_0 (
    .clk(sprot_if_0.clk),
    .a(sprot_if_0.a),
    .b(sprot_if_0.b),
    .rst_n(sprot_if_0.rst_n),
    .start(sprot_if_0.start),
    .prot_err(sprot_if_0.prot_err),
    .xfer_end(sprot_if_0.xfer_end)
  );


  initial begin : go2uvm_test
    uvm_config_db #(virtual sprot_if)::set(null,"*","vif",sprot_if_0);
    // Kick start standard UVM phasing
   // $dumpfile("dump.vcd");
   //  $dumpvars;
    run_test ("G2U_sig_access_test");
  end : go2uvm_test
endmodule : sprot_go2uvm
