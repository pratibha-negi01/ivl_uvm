class fifo_base_test extends uvm_test;
  
  fifo_env env_0;
  
  `uvm_component_utils(fifo_base_test)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
        
endclass : fifo_base_test
    
    function void fifo_base_test::build_phase(uvm_phase phase);
          super.build_phase(phase);
          env_0= fifo_env::type_id::create(.name("env_0"),.parent(this));
    endfunction : build_phase
    
    function void fifo_base_test::end_of_elaboration_phase(uvm_phase phase);
          uvm_top.print_topology();
    endfunction : end_of_elaboration_phase
    
    task fifo_base_test::main_phase(uvm_phase phase);
          phase.raise_objection(this);
          `uvm_info("Base Test","Test is running...",UVM_LOW)
          #1000;
          
          `uvm_info("Base Test", "User activated end of simulation",UVM_LOW)
          phase.drop_objection(this);
    endtask : main_phase
    
    
  
    
