////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_acces
// Class Name   : G2U_sig_access_sequence
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////

class Go2UVM_sig_access_base_rseqs extends uvm_sequence #(G2U_sig_access_trans);

   `uvm_object_utils(Go2UVM_sig_access_base_rseqs)

    G2U_sig_access_trans xtn;
   
    function new (string name = "Go2UVM_sig_access_base_rseqs");
       super.new(name);
    endfunction
  

task body();
     repeat(5);
	xtn = G2U_sig_access_trans::type_id::create("xtn");
   start_item(xtn);      
	assert(xtn.randomize() with {cmd==IDLE;});
    `uvm_info(" Sequence",$sformatf("printing for IDLE \n%s",xtn.sprint()),UVM_LOW)
    finish_item(xtn);
	#20;
	start_item(xtn);      
	assert(xtn.randomize() with {cmd==A_ST;});
    `uvm_info(" Sequence",$sformatf("printing for A_ST \n%s",xtn.sprint()),UVM_LOW)
    finish_item(xtn);
	#10;
	start_item(xtn); 
	assert(xtn.randomize() with {cmd==B_ST;});
    `uvm_info(" Sequence",$sformatf("printing for B_ST \n%s",xtn.sprint()),UVM_LOW)
    finish_item(xtn);
	
   endtask 
endclass
	
