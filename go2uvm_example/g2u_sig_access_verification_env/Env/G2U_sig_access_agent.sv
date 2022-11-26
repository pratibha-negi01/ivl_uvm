////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_agent
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////


class Go2UVM_sig_access_agent extends uvm_agent;

    `uvm_component_utils(Go2UVM_sig_access_agent)
	Go2UVM_sig_access_Driver drvh1;
	Go2UVM_sig_access_monitor  mon_h;
	Go2UVM_sig_access_sequencer seqr_h;
   virtual sprot_if vif;
   
   function new (string name = "Go2UVM_sig_access_agent", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 drvh1=Go2UVM_sig_access_Driver::type_id::create("drvh1",this);
	 mon_h = Go2UVM_sig_access_monitor::type_id::create("mon_h",this);
	 seqr_h = Go2UVM_sig_access_sequencer::type_id::create("seqr_h",this);
     if (!uvm_config_db#(virtual sprot_if)::get(this,"","vif", vif)) begin
        `uvm_fatal("RAM_READ_AGENT", "The virtual interface get failed");
		end
   endfunction
   
   function void connect_phase (uvm_phase phase);
     drvh1.seq_item_port.connect(seqr_h.seq_item_export);
	  drvh1.sprot_if_0 = vif;
	  mon_h.sprot_if_0 = vif;
   endfunction
   
endclass
