class fifo_sequencer extends uvm_sequencer #(fifo_seq_item);
  fifo_seq_item x0;
  `uvm_component_utils(fifo_sequencer)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
endclass : fifo_sequencer
