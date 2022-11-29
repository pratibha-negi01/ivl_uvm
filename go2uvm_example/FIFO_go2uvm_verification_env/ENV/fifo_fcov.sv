class fifo_fcov extends uvm_subscriber #(fifo_seq_item);
  fifo_seq_item item1;
  
  `uvm_component_utils_begin(fifo_fcov)
  `uvm_field_object(item1, UVM_ALL_ON)
  `uvm_component_utils_end
  
  uvm_analysis_imp#(fifo_seq_item, fifo_fcov) analysis_export;
  
 covergroup s_cg;
   
   coverpoint item1.empty{
     bins empty_check1 = {1'b1};
   }
   coverpoint item1.full{
     bins full_check1 = {1'b1};
   }
   
   coverpoint item1.pofe{
     bins pofe_check1 = {1'b1};
   }
   coverpoint item1.poee{
     bins poee_check1 = {1'b1};
   }
   
   
   option.per_instance=1;
   
 endgroup : s_cg
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    analysis_export= new("analysis_export",this);
    this.s_cg= new();
  endfunction : new
  
  extern virtual function void write(fifo_seq_item t);
  extern virtual function void report_phase(uvm_phase phase);
  
 endclass : fifo_fcov
    
    
    
    function void fifo_fcov::write(fifo_seq_item t);
      this.item1= t;
      this.s_cg.sample();
    endfunction : write 
    
    function void fifo_fcov::report_phase(uvm_phase phase);
      `uvm_info("get_name()",$sformatf("The functional coverage : %f", this.s_cg.get_coverage()),UVM_NONE)
      
    endfunction : report_phase 
