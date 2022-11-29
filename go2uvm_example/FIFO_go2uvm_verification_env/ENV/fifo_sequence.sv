class fifo_rand_seq extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_rand_seq)
  
  function new(string name= "fifo_rand_seq");
    super.new(name);
  endfunction : new
  
  extern virtual task body();
    
endclass : fifo_rand_seq
    
    
   task fifo_rand_seq::body();
      `uvm_info(get_name(), $sformatf(" Sequence is running.. \n"), UVM_LOW)
     
      //alternate push and pop
      
      `uvm_do_with(req,{this.kind== PUSH;})
      #20;
      
      `uvm_do_with(req,{this.kind== POP;})
      #20;
     
     `uvm_do_with(req,{this.kind== PUSH;})
      #20;
     
     `uvm_do_with(req,{this.kind== POP;})
      #20;
     `uvm_do_with(req,{this.kind== PUSH;})
      #20;
     
     `uvm_do_with(req,{this.kind== POP;})
      #20;
     
     //10 push 
     repeat(18) begin
     
      `uvm_do_with(req,{this.kind== PUSH;})
      #20;
     end
     
     //10 pop
     
     repeat(18) begin
       
     `uvm_do_with(req,{this.kind== POP;})
     #20;
     end
     
     
      
      `uvm_info(get_name(),$sformatf(" Sequence is Complete...\n"),UVM_LOW)
    endtask : body 
   
