////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_scoreboard
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////


class Go2UVM_sig_access_scoreboard extends uvm_scoreboard;
`uvm_component_utils(Go2UVM_sig_access_scoreboard)

G2U_sig_access_trans trans;
uvm_tlm_analysis_fifo #(G2U_sig_access_trans) an_imp1;



function new (string name="Go2UVM_sig_access_scoreboard",uvm_component parent = null);
         super.new(name,parent);
       an_imp1 = new("an_imp1",this);
	   endfunction
	   

	 
	  task run_phase(uvm_phase phase);
     forever  begin
	   //monitor();
	  
	  an_imp1.get(trans);
	  
		ref_model();
 check_data();
	 
	   end
   endtask
   
   
    
   
	  
    
    task check_data();
  
		   endtask
	  
	  
	   task ref_model();
	 
	
	
	   endtask
endclass
