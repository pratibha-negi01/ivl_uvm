class fifo_agent_pas extends uvm_agent;
  `uvm_component_utils(fifo_agent_pas)
  fifo_monitor_pas mon_out;
  uvm_analysis_port#(fifo_trans)aport;
  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_out=new("monitor_out",this);
    aport=new("agent_out",this);
    mon_out.mon_aport=new("mon_out_port",this);
    //`uvm_info(get_type_name(),"agent out",UVM_LOW);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon_out.mon_aport.connect(aport);
    //`uvm_info(get_type_name(),"connect agent out",UVM_LOW);
  endfunction
endclass
