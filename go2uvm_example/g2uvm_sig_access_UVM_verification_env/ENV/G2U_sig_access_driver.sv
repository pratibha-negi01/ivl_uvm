////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_driver
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////


class Go2UVM_sig_access_Driver extends uvm_driver #(G2U_sig_access_trans);

   `uvm_component_utils(Go2UVM_sig_access_Driver)
   
   virtual sprot_if sprot_if_0;
   G2U_sig_access_trans xtn;
      
   function new (string name = "Go2UVM_sig_access_Driver", uvm_component parent=null);
       super.new(name,parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual sprot_if)::get(this,"","vif",sprot_if_0))
    `uvm_fatal(get_type_name()," driver not get the config")
   endfunction
   
   task run_phase(uvm_phase phase);
     begin
	 uvm_report_info (get_type_name (), $sformatf ("Start of reset"),UVM_LOW, `__FILE__ , `__LINE__ );
     this.sprot_if_0.cb.rst_n <= 1'b0;
     repeat (5) @ (this.sprot_if_0.cb);
     this.sprot_if_0.cb.rst_n <= 1'b1;
     repeat (1) @ (this.sprot_if_0.cb);
	 uvm_report_info (get_type_name (), $sformatf ("End of reset"),UVM_LOW, `__FILE__ , `__LINE__ );
     end
     forever begin
       fork
	   begin
	   uvm_report_info (get_type_name (), $sformatf ("Wait for sequence item"),UVM_LOW, `__FILE__ , `__LINE__ );
	   seq_item_port.get_next_item(xtn);
	   uvm_report_info (get_type_name (), $sformatf ("get next sequence item"),UVM_LOW, `__FILE__ , `__LINE__ );
	   send_to_dut(xtn);
	   uvm_report_info (get_type_name (), $sformatf ("sequence item send to DUT"),UVM_LOW, `__FILE__ , `__LINE__ );
	   seq_item_port.item_done();
	   end
       join
	 end
   endtask
  
  
   
task send_to_dut(G2U_sig_access_trans req);
case (xtn.cmd)
    xtn.IDLE:
             begin:IDLE
               idle_cmd();
             end:IDLE			   
    xtn.A_ST:
	          begin:A_ST
			  if(xtn.a ==1)
	            a_start_cmd();
				else
				b_start_cmd();
			  end:A_ST
	 xtn.B_ST:
	          begin:B_ST
			  if(xtn.b ==1)
	            b_start_cmd();
				else
				idle_cmd();
			  end:B_ST
			  
endcase
   uvm_report_info (get_type_name (), $sformatf ("starting force signal"),UVM_LOW, `__FILE__ , `__LINE__ );
     $signal_force("/sprot_go2uvm/sprot_0/byte_val","'d22");
    #100;
    $signal_force("/sprot_go2uvm/sprot_0/byte_val_1", "'haa");
    #100;
     uvm_report_info (get_type_name (), $sformatf ("End main"),UVM_LOW, `__FILE__ , `__LINE__ );
endtask

task idle_cmd();
      @(this.sprot_if_0.cb); 
      this.sprot_if_0.cb.start <= 1'b1; 
      @ (this.sprot_if_0.cb); 
      this.sprot_if_0.cb.start <= 1'b0;  
	  
endtask	 

task a_start_cmd();
      @(this.sprot_if_0.cb); 
      this.sprot_if_0.cb.a <= 1'b1; 
      @(this.sprot_if_0.cb);
      this.sprot_if_0.cb.a <= 1'b0; 
	  
      
endtask
	  
 task b_start_cmd();
 begin
	//  @(this.sprot_if_0.cb); 
	   @(this.sprot_if_0.cb); 
      this.sprot_if_0.cb.b <= 1'b1; 
      @ (this.sprot_if_0.cb); 
      this.sprot_if_0.cb.b <= 1'b0; 
	  end
 endtask

endclass
