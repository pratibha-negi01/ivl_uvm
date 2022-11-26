////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_monitor
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////


class Go2UVM_sig_access_monitor extends uvm_monitor;
 
  `uvm_component_utils(Go2UVM_sig_access_monitor)
 G2U_sig_access_trans trans_h;
  uvm_analysis_port #(G2U_sig_access_trans) an_port;
  
   virtual sprot_if sprot_if_0;
   
   function new (string name = "Go2UVM_sig_access_monitor", uvm_component parent=null);
	  super.new(name,parent);
	  an_port = new("an_port",this);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction
   
   task run_phase(uvm_phase phase);
    forever begin
	   monitor();
	  
	   end
   endtask
   
  task monitor();
      //handle creation
	 trans_h = new();
	@(this.sprot_if_0.cb);
	trans_h.a = sprot_if_0.cb.a;
	trans_h.b = sprot_if_0.cb.b;
  endtask
   
endclass
