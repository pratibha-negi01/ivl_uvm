class fifo_enviro extends uvm_env;
  `uvm_component_utils(fifo_enviro)
  
  fifo_agent_act		agent_in;
  fifo_agent_pas		agent_out;
  fifo_score			score;
  
  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_in=new("AGENT_IN",this);
    agent_out=new("AGENT_OUT",this);
    score=new("scoreboard",this);
    //`uvm_info(get_type_name(),"environment build",UVM_LOW);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_in.aport.connect(score.sbexport_in);
    agent_out.aport.connect(score.sbexport_out);
    //`uvm_info(get_type_name(),"enviro connect phase",UVM_LOW);
  endfunction
endclass
