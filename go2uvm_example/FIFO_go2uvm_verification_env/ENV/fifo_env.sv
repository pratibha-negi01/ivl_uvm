class fifo_env extends uvm_env;
  fifo_agent fifo_agent1;
  
  `uvm_component_utils(fifo_env)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  extern virtual function void build_phase(uvm_phase phase);
    
endclass : fifo_env
    
    function void fifo_env::build_phase(uvm_phase phase);
      super.build_phase(phase);
      fifo_agent1= fifo_agent::type_id::create("fifo_agent1",this);
      
      uvm_config_db#(uvm_active_passive_enum)::set(.cntxt(this),.inst_name("*"),.field_name("is_active"),.value(UVM_ACTIVE));
      
      
    endfunction : build_phase 
