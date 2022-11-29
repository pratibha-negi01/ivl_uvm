////////////////////////////////////////////////////////////////
// Project Name : Fifo_go2uvm
// Class Name   : fifo_trans
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : RaviSingh, Shahul, Vicky, Pratibha, Annie
///////////////////////////////////////////////////////////////
import fifo_pkg::*;

class fifo_seq_item extends uvm_sequence_item;
  
  rand logic [DATA_WIDTH-1:0]wr_data;
  logic [DATA_WIDTH-1:0]rd_data;
  rand fifo_op kind;
  bit full,empty,pofe,poee; //poee :- POP ON EMPTY ERROOR, pofe:- PUSH ON FULL ERROR
  bit [3:0] no_of_rst;
  
  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(wr_data,UVM_ALL_ON)
  `uvm_field_int(rd_data,UVM_ALL_ON)
  `uvm_field_int(full,UVM_ALL_ON)
  `uvm_field_int(empty,UVM_ALL_ON)
  `uvm_field_int(pofe,UVM_ALL_ON)
  `uvm_field_int(poee,UVM_ALL_ON)
  `uvm_field_enum(fifo_op,kind,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction : new
  
endclass : fifo_seq_item
