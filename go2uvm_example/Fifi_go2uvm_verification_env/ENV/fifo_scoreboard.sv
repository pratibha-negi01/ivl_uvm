`define DATA_WIDTH 8
`define ADDR_WIDTH 4 
class fifo_score extends uvm_scoreboard;
  `uvm_component_utils(fifo_score)
  fifo_trans tr1, tr2;
  parameter DEPTH = 2**`ADDR_WIDTH-1;
  reg [`DATA_WIDTH-1:0] mem [0:2**`ADDR_WIDTH-1];
  reg address=0;
  reg address_1=0;
 // reg [`DATA_WIDTH-1:0]
  reg [4:0] w_ptr,r_ptr;
  int result;
  
  uvm_analysis_export#(fifo_trans) sbexport_in, sbexport_out;
  uvm_tlm_analysis_fifo#(fifo_trans) fifo_in, fifo_out;
  
  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sbexport_in=new("sbexport_in",this);
    sbexport_out=new("sbexport_out",this);
    fifo_in=new("fifo_in",this);
    fifo_out=new("fifo_out",this);
    //`uvm_info(get_type_name(),"scoreboard_build",UVM_LOW);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    sbexport_in.connect(fifo_in.analysis_export);
    sbexport_out.connect(fifo_out.analysis_export);
   // `uvm_info(get_type_name(),"scoreboard connect",UVM_LOW);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    repeat(`number)
      begin
    fifo_in.get(tr1);
    fifo_out.get(tr2);
    /////reset////////
        if(tr1.rst_n==0)
            if(tr2.data_out==0)
              begin
            `uvm_info(get_type_name(),$sformatf("DATA OUT=%d",tr2.data_out),UVM_LOW);
            `uvm_info(get_type_name(),"============RESET CONDITION PASS================",UVM_LOW);
               w_ptr=0;
            r_ptr=0;
          	  end
        else
          `uvm_info(get_type_name(),"==================RESET CONDITION FAILED==============",UVM_LOW);
        
        
        if(tr1.push & !tr2.full)
          begin
            mem[w_ptr]<=tr1.data_in;
            `uvm_info(get_type_name(),"============Correct_write================",UVM_LOW);
            `uvm_info(get_type_name(),$sformatf("mem[w_ptr]=%d tr2.data_out=%d ",mem[w_ptr],tr2.data_out),UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("mem[r_ptr]=%d tr2.data_out=%d ",mem[r_ptr],tr2.data_out),UVM_LOW);
        //if(tr1.pop)
            w_ptr=w_ptr+1;
          end
       // `uvm_info(get_type_name(),$sformatf("mem[w_ptr]=%d tr2.data_out=%d ",mem[w_ptr],tr2.data_out),UVM_LOW);
        //`uvm_info(get_type_name(),$sformatf("mem[r_ptr]=%d tr2.data_out=%d ",mem[r_ptr],tr2.data_out),UVM_LOW);
        if(tr1.pop & !tr2.empty)
         // begin
            //r_ptr=r_ptr+1;
          if(mem[r_ptr+1]==tr2.data_out)
            begin
            
              `uvm_info(get_type_name(),"============Correct_read================",UVM_LOW);
              `uvm_info(get_type_name(),$sformatf("mem[r_ptr]=%d tr2.data_out=%d ",mem[r_ptr+1],tr2.data_out),UVM_LOW);
              r_ptr=r_ptr+1;
          end
          //end
        
     
        `uvm_info(get_type_name(),$sformatf("w_ptr=%d   r_ptr=%d ",w_ptr,r_ptr),UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("DEPTH=%d ",DEPTH),UVM_LOW);
        if(tr2.full)
          if(w_ptr  - r_ptr==DEPTH+2)
          //if( ((r_ptr==0)&(w_ptr==DEPTH) )||((r_ptr!==0)&(w_ptr==r_ptr-1) ))
            begin
              `uvm_info(get_type_name(),"============FULL================",UVM_LOW);
            end
       
        if(tr2.empty)
          if(w_ptr-2==r_ptr)//||((w_ptr-1==r_ptr) & (tr1.push)))
            begin
              `uvm_info(get_type_name(),$sformatf("tr2.empty=%d ",tr2.empty),UVM_LOW);
            `uvm_info(get_type_name(),"============EMPTY================",UVM_LOW);
            end
        
        
     
      end  
  endtask
  
endclass 
