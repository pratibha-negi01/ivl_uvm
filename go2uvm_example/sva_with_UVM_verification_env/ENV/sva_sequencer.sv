class sva_sequencer extends uvm_sequencer#(sva_seq_item);

  `uvm_component_utils(sva_sequencer) 

  //---------------------------------------
  //constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
