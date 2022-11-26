//-------------------------------------------------------------------------
//						sva_env 
//-------------------------------------------------------------------------

`include "sva_agent.sv"
`include "sva_scoreboard.sv"

class sva_env extends uvm_env;
  
  //---------------------------------------
  // agent and scoreboard instance
  //---------------------------------------
  sva_agent      sva_agnt;
  sva_scoreboard sva_scb;
  
  `uvm_component_utils(sva_env)
  
  //--------------------------------------- 
  // constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase - crate the components
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    sva_agnt = sva_agent::type_id::create("sva_agnt", this);
    sva_scb  = sva_scoreboard::type_id::create("sva_scb", this);
  endfunction : build_phase
  
  //---------------------------------------
  // connect_phase - connecting monitor and scoreboard port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    sva_agnt.monitor.item_collected_port.connect(sva_scb.item_collected_export);
  endfunction : connect_phase

endclass : sva_env
