////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_sequencer
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////

class Go2UVM_sig_access_sequencer extends uvm_sequencer #(G2U_sig_access_trans);

  `uvm_component_utils(Go2UVM_sig_access_sequencer)
   
   function new (string name = "Go2UVM_sig_access_sequencer", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
endclass
