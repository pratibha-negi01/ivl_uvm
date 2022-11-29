class fifo_rand_test extends fifo_base_test;
  `uvm_component_utils(fifo_rand_test)
  fifo_rand_seq rand_seq1;
  
  extern virtual task main_phase(uvm_phase phase);
    
    function new(string name, uvm_component parent=null);
      super.new(name,parent);
    endfunction : new
  
endclass : fifo_rand_test
    
    task fifo_rand_test::main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("Rand Test","Test is running..",UVM_LOW)
      #500;
      
      rand_seq1= fifo_rand_seq::type_id::create("rand_seq1",this);
      
      this.rand_seq1.start(env_0.fifo_agent1.fifo_sequencer1);
      
      #500;
      `uvm_info("Rand Test","User activated end of simulation.",UVM_LOW)
      phase.drop_objection(this);
      
    endtask : main_phase
