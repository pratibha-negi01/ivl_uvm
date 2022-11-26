`include "sva_seq_item.sv"
`include "sva_sequencer.sv"
`include "sva_sequence.sv"
`include "sva_driver.sv"
`include "sva_monitor.sv"

class sva_agent extends uvm_agent;

  //---------------------------------------
  // component instances
  //---------------------------------------
  sva_driver    driver;
  sva_sequencer sequencer;
  sva_monitor   monitor;

  `uvm_component_utils(sva_agent)
  
  //---------------------------------------
  // constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = sva_monitor::type_id::create("monitor", this);

    //creating driver and sequencer only for ACTIVE agent
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = sva_driver::type_id::create("driver", this);
      sequencer = sva_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase
  
  //---------------------------------------  
  // connect_phase - connecting the driver and sequencer port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : sva_agent
