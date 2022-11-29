// Code your testbench here
// or browse Examples
`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo_file.svh"

module fifo_top();
  
  logic clk;
  initial begin : clk_gen
   clk<=1'b0;
   forever #5 clk= ~clk;
   end : clk_gen
  
  fifo_if fifo_if0(.clk(clk));
  
  fifo fifo_1(.clk(fifo_if0.clk),.rst_n(fifo_if0.rst),.push(fifo_if0.push),.pop(fifo_if0.pop),.data_in(fifo_if0.data_in),.data_out(fifo_if0.data_out),.push_err_on_full(fifo_if0.push_err_on_full),.pop_err_on_empty(fifo_if0.pop_err_on_empty),.full(fifo_if0.full),.empty(fifo_if0.empty));
  
 initial begin 
   uvm_config_db#(virtual fifo_if)::set(.cntxt(null),.inst_name("uvm_test_top.env_0.fifo_agent1"),.field_name("if_1"),.value(fifo_if0));
   
   run_test();
 end
   
  
  
  
  
endmodule : fifo_top
    
    
