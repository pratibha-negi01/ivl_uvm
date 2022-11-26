////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_env
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////


class Go2UVM_sig_access_env extends uvm_env;

    `uvm_component_utils(Go2UVM_sig_access_env)
	
	
	Go2UVM_sig_access_agent agent_h;
	Go2UVM_sig_access_Driver mon_h;
	Go2UVM_sig_access_scoreboard sb_h;
    
   
   function new (string name = "Go2UVM_sig_access_env", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 agent_h = Go2UVM_sig_access_agent::type_id::create("agent_h",this);
	 sb_h=Go2UVM_sig_access_scoreboard::type_id::create("sb_h",this);
	 
   endfunction
     function void connect_phase(uvm_phase phase);
	 agent_h.mon_h.an_port.connect(sb_h.an_imp1.analysis_export);
	 endfunction
   
   
endclass
