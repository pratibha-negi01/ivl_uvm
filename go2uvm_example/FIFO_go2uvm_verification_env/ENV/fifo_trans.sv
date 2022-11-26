////////////////////////////////////////////////////////////////
// Project Name : Fifo_go2uvm
// Class Name   : fifo_trans
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : RaviSingh, Shahul, Vicky, Pratibha, Annie
///////////////////////////////////////////////////////////////
`define DATA_WIDTH 8
`define ADDR_WIDTH 4 
class fifo_trans extends uvm_sequence_item;
  function new(string name="");
    super.new(name);
  endfunction
  rand bit [`DATA_WIDTH-1:0] data_in;
  rand bit rst_n,push,pop;
  bit [`DATA_WIDTH-1:0] data_out;
  bit push_err_on_full,pop_err_on_empty, full,empty;
  
  
  `uvm_object_utils_begin(fifo_trans)
  `uvm_field_int(data_in,UVM_ALL_ON)
  `uvm_field_int(rst_n,UVM_ALL_ON)
  `uvm_field_int(push,UVM_ALL_ON)
  `uvm_field_int(pop,UVM_ALL_ON)
  `uvm_field_int(data_out,UVM_ALL_ON)
  `uvm_field_int(push_err_on_full,UVM_ALL_ON)
  `uvm_field_int(pop_err_on_empty,UVM_ALL_ON)
  `uvm_field_int(full,UVM_ALL_ON)
  `uvm_field_int(empty,UVM_ALL_ON)
  `uvm_object_utils_end
endclass
