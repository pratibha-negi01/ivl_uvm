class fifo_agent_act extends uvm_agent;
  `uvm_component_utils(fifo_agent_act)
  
  fifo_dri dri;
  fifo_sequencer seq;
  fifo_monitor_act mon_in;
  
  uvm_analysis_port#(fifo_trans) aport;
  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dri=new("driver",this);
    seq=new("sequencer",this);
    mon_in=new("monitor",this);
    aport=new("agent_act",this);
    mon_in.mon_act_port=new("monitor_analysis",this);
   // `uvm_info(get_type_name(),"uvm_agent_act",UVM_LOW);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //`uvm_info(get_type_name(),"agent_act",UVM_LOW);
    dri.seq_item_port.connect(seq.seq_item_export);
    mon_in.mon_act_port.connect(aport);
  endfunction
endclass
