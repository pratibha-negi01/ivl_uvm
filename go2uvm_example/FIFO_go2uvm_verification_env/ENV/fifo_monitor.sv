class fifo_monitor extends uvm_monitor;
  
  virtual fifo_if vif1;
  fifo_seq_item item1;
  
  uvm_analysis_port #(fifo_seq_item) push_m_aport;
  uvm_analysis_port #(fifo_seq_item) pop_m_aport;
  
  `uvm_component_utils_begin(fifo_monitor)
  `uvm_field_object(item1,UVM_ALL_ON);
  `uvm_component_utils_end
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    push_m_aport= new("push_m_aport",this);
    pop_m_aport= new("pop_m_aport",this);
  endfunction : new
  
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task collect_data();
  
endclass : fifo_monitor
    
     task fifo_monitor::run_phase(uvm_phase phase);
        `uvm_info(get_name(),"run_phase is running... \n ", UVM_HIGH)
       collect_data();
    endtask : run_phase
    
    task fifo_monitor::collect_data();
      forever begin
        @(this.vif1.monitor_cb);
        wait(this.vif1.monitor_cb.rst==1'b1);
        if(this.vif1.monitor_cb.push==1'b1 && this.vif1.monitor_cb.pop==1'b0)
        begin
                 item1= fifo_seq_item::type_id::create("item1",this);
                 item1.kind= fifo_op'(vif1.monitor_cb.push);
                 item1.wr_data=vif1.monitor_cb.data_in;
                 @(this.vif1.monitor_cb);
                 item1.full=vif1.monitor_cb.full;
                 item1.pofe=vif1.monitor_cb.push_err_on_full;
                 item1.empty=vif1.monitor_cb.empty;
                 item1.poee=vif1.monitor_cb.pop_err_on_empty;
        
              `uvm_info(get_name(),$sformatf(" monitor collected push xactn : \n %s", item1.sprint()),UVM_MEDIUM)
          if(item1.full)
            `uvm_warning("MONITOR","Found FIFO is full")
          if(item1.pofe)
          `uvm_warning("MONITOR","Found PUSH ON FULL ERROR FROM DUT")
            
        this.push_m_aport.write(item1);
        end
          
              
        else if(this.vif1.monitor_cb.push==1'b0 && this.vif1.monitor_cb.pop==1'b1)
          begin
         @(this.vif1.monitor_cb);
        item1= fifo_seq_item::type_id::create("item1",this);
        item1.kind= fifo_op'(vif1.monitor_cb.push);
        item1.rd_data=vif1.monitor_cb.data_out;
        item1.empty=vif1.monitor_cb.empty;
        item1.poee=vif1.monitor_cb.pop_err_on_empty;
        item1.full=vif1.monitor_cb.full;
        item1.pofe=vif1.monitor_cb.push_err_on_full;
       `uvm_info(get_name(),$sformatf(" monitor collected pop xactn: \n %s", item1.sprint()),UVM_MEDIUM)
            
            if(item1.empty)
            `uvm_warning("MONITOR","Found FIFO is empty")
       
              if(item1.poee)  
            `uvm_warning("MONITOR","Found POP ON EMPTY ERROR FROM DUT ")
              
            
        this.pop_m_aport.write(item1);
        end
            
      end
    endtask : collect_data
    
