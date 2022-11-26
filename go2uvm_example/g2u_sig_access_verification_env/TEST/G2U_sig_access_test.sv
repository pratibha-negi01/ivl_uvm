import uvm_pkg::*;
//`include "uvm_pkg.sv"
import pkg::*;
class G2U_sig_access_test extends uvm_test;
 `include "uvm_macros.svh"
  `uvm_component_utils(G2U_sig_access_test)

  Go2UVM_sig_access_env env_h;
  Go2UVM_sig_access_base_rseqs seqs_h;
  Go2UVM_sig_access_agent agent_h;

 
  function new (string name = "G2U_sig_access_test", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
  function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 env_h = Go2UVM_sig_access_env::type_id::create("env_h",this);
	 seqs_h =  Go2UVM_sig_access_base_rseqs::type_id::create(" seqs_h ",this);
   endfunction
  
     
  function void end_of_elaboration_phase (uvm_phase phase);
	uvm_top.print_topology();
   endfunction
  
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
	 seqs_h=Go2UVM_sig_access_base_rseqs::type_id::create("seqs_h");
	// fork
       seqs_h.start(env_h.agent_h.seqr_h);
     //join
   
	#5000; 
   $finish;
 phase.drop_objection(this);
  endtask
endclass
