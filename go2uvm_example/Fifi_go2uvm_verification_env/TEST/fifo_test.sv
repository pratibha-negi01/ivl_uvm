class fifo_tb extends uvm_test;
  `uvm_component_utils(fifo_tb)
  fifo_enviro env;
  fifo_sequence sec;
  
  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=new("environment",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    //`uvm_info(get_type_name(),"test bench",UVM_LOW);
    sec=new("sequencee");
    sec.start(env.agent_in.seq);
    phase.drop_objection(this);
  endtask
endclass
