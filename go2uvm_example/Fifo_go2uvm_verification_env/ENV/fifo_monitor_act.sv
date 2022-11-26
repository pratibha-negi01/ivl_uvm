class fifo_monitor_act extends uvm_monitor;
  `uvm_component_utils(fifo_monitor_act)
  
  virtual fifo_if vif;
  fifo_trans tns;
  
  uvm_analysis_port#(fifo_trans) mon_act_port;
  function new(string name="", uvm_component parent);
    super.new(name, parent);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","iface",vif))
      `uvm_fatal(get_type_name(),"interface not set monitor");
  endfunction
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    repeat(`number)
      begin
      tns=new("tns");
        @(negedge vif.clk);
      tns.data_in<=vif.data_in;
        `uvm_info(get_type_name(),$sformatf("input value monitor    DATA_IN=%d",vif.data_in),UVM_LOW);
      tns.rst_n<=vif.rst_n;
        `uvm_info(get_type_name(),$sformatf("input value monitor   RST_N=%d",vif.rst_n),UVM_LOW);
        tns.push<=vif.push;
        `uvm_info(get_type_name(),$sformatf("input value monitor   PUSH=%d",vif.push),UVM_LOW);
        tns.pop<=vif.pop;
        `uvm_info(get_type_name(),$sformatf("input value monitor   POP=%d",vif.pop),UVM_LOW);
      
      mon_act_port.write(tns);
      //`uvm_info(get_type_name,"monitor writing",UVM_LOW);
    end
  endtask
endclass
