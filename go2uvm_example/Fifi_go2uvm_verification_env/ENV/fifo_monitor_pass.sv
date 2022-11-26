class fifo_monitor_pas extends uvm_monitor;
  `uvm_component_utils(fifo_monitor_pas)
  
  virtual fifo_if vif;
  fifo_trans tns;
  
  uvm_analysis_port#(fifo_trans) mon_aport;
  function new(string name="", uvm_component parent);
    super.new(name, parent);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","iface",vif))
      `uvm_fatal(get_type_name(),"interface not set monitor");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    @(posedge vif.clk);
    repeat(`number)
      begin
        @(posedge vif.clk);
      tns=new("tns");
        //@(posedge vif.sysclk);
        tns.full=vif.full;
        `uvm_info(get_type_name(),$sformatf("input value monitor  FULL=%d",vif.full),UVM_LOW);
        tns.empty=vif.empty;
        `uvm_info(get_type_name(),$sformatf("input value monitor  EMPTY=%d",vif.empty),UVM_LOW);
        tns.push_err_on_full=vif.push_err_on_full;
        `uvm_info(get_type_name(),$sformatf("input value monitor  PUSH_ERR_ON_FULL=%d",vif.push_err_on_full),UVM_LOW);
        tns.pop_err_on_empty=vif.pop_err_on_empty;
        `uvm_info(get_type_name(),$sformatf("input value monitor  PUSH_ERR_ON_EMPTY=%d",vif.pop_err_on_empty),UVM_LOW);
      tns.data_out=vif.data_out;
        `uvm_info(get_type_name(),$sformatf("input value monitor  DATA_OUT=%d",vif.data_out),UVM_LOW);
  
      
      mon_aport.write(tns);
        @(negedge vif.clk);
      //`uvm_info(get_type_name(),"monitor",UVM_LOW);
    end
  endtask
endclass
