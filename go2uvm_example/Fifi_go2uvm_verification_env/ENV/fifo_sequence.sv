class fifo_sequence extends uvm_sequence#(fifo_trans);
  `uvm_object_utils(fifo_sequence)
  fifo_trans tr;
  function new(string name="");
     super.new(name);
  endfunction
  
  task body;
    ////////Reset ////////
    repeat(1)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==0;});
        finish_item(tr);
      end

    ////////////////write/PUSH/////////////////////
    repeat(19)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1; push==1;pop==0;});
        finish_item(tr);
      end
    
    //////////////read/POP/////////////////////
    repeat(19)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1; push==0;pop==1;});
        finish_item(tr);
      end 
    
    //////////////During PUSH/POP/RESET///////////
    
    repeat(5)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1; push==1; pop==0;});
        finish_item(tr);
      end 
    repeat(2)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1; push==0;pop==1;});
        finish_item(tr);
      end
    repeat(1)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==0;});
        finish_item(tr);
      end
    repeat(2)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1; push==1;pop==0;});
        finish_item(tr);
      end
    repeat(5)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1; push==0;pop==1;});
        finish_item(tr);
      end 
    
    repeat(50)
      begin
        tr=new("trans");
        start_item(tr);
        void'(tr.randomize() with {rst_n==1;});
        finish_item(tr);
      end 
  endtask
endclass
