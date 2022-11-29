class fifo_scoreboard extends uvm_scoreboard;
  
  fifo_seq_item push_m_item;
  fifo_seq_item pop_m_item;
  
  `uvm_component_utils_begin(fifo_scoreboard)
  `uvm_field_object(push_m_item,UVM_ALL_ON)
  `uvm_field_object(pop_m_item,UVM_ALL_ON)
  `uvm_component_utils_end
  
  uvm_tlm_analysis_fifo #(fifo_seq_item) push_m_fifo;
  uvm_tlm_analysis_fifo #(fifo_seq_item) pop_m_fifo;
  
  int num_of_dut_error=0;
  
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    push_m_fifo= new("push_m_fifo",this);
    pop_m_fifo= new("pop_m_fifo",this);
  endfunction : new
  
  
  extern virtual task run_phase(uvm_phase phase);
  
  
endclass : fifo_scoreboard
    
    task fifo_scoreboard::run_phase(uvm_phase phase);
      forever begin
        `uvm_info(get_name(),"Run phase is running..",UVM_HIGH)
        this.push_m_fifo.get(push_m_item);
        `uvm_info("SBRD","Found 1 push xaction from monitor \n ",UVM_HIGH)
        this.pop_m_fifo.get(pop_m_item);
        `uvm_info("SBRD","Found 1 pop xactn from monitor \n ",UVM_HIGH)
        
        if(pop_m_item.rd_data==push_m_item.wr_data)
          begin
            `uvm_info("SBRD",$sformatf("PASS , NO OF DUT ERROR : %0d",num_of_dut_error),UVM_MEDIUM)
          end
        else
          begin
            num_of_dut_error++;
            `uvm_error("SBRD",$sformatf("FAIL! \n ,Expected data :%0d  Actual_data:%0d  , NO OF DUT ERROR : %0d",push_m_item.wr_data, pop_m_item.rd_data, num_of_dut_error));
          end
        
        
          
      end
    endtask :run_phase
  
