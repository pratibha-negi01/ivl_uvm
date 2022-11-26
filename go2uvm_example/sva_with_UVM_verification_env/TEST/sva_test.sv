////////////////////////////////////////////////////////////////
// Project Name : sva_with_UVM
// Class Name   : sva_test
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Yugesh , Shivshankar , Arunachalam , Usha, Adil
///////////////////////////////////////////////////////////////

`include "sva_env.sv"
class sva_test extends uvm_test;

  `uvm_component_utils(sva_test)
  
  //---------------------------------------
  // sequence instance 
  //--------------------------------------- 
  sva_sequence seq;
  sva_env env;
  //---------------------------------------
  // constructor
  //---------------------------------------
  function new(string name = "sva_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the sequence
    seq = sva_sequence::type_id::create("seq");
    // Create the env
    env = sva_env::type_id::create("env", this);
  endfunction : build_phase
  
  //---------------------------------------
  // end_of_elobaration phase
  //---------------------------------------  
  virtual function void end_of_elaboration();
    //print's the topology
    print();
  endfunction
  //---------------------------------------
  // run_phase - starting the test
  //---------------------------------------
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    seq.start(env.sva_agnt.sequencer);
    phase.drop_objection(this);
    
  endtask : run_phase
  
endclass : sva_test
