class fifo_dri extends uvm_driver#(fifo_trans);
  `uvm_component_utils(fifo_dri)
  
  fifo_trans tr;
  virtual fifo_if inter;
  
  function new(string name="", uvm_component parent);
    super.new(name, parent);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","iface",inter))
      begin
      `uvm_fatal(get_type_name(),"interface driver");
      end
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    repeat(`number)
      begin
        @(posedge inter.clk);
        seq_item_port.get_next_item(tr);
       // `uvm_info(get_type_name(),"driving data",UVM_LOW);
        drive();
        seq_item_port.item_done();
      end
  endtask
 /* task drive;
  
  //// @(negedge inter.sysclk);
    inter.data_in<=tr.data_in;
    inter.rst_n<=tr.rst_n;
     inter.push<=tr.push;
    inter.pop<=tr.pop;
   //// @(posedge inter.sysclk);
  endtask */
  task drive;
   // if(tr.rst_n==0)
      begin
        inter.rst_n<=tr.rst_n;
      reset();
      end
    //else
      if(tr.push)
        begin
          inter.data_in<=tr.data_in;
          inter.push<=tr.push;
        end
    else
      inter.pop<=tr.pop;
          
   // @(negedge inter.sysclk);
    //inter.data_in<=tr.data_in;
    //inter.rst_n<=tr.rst_n;
    // inter.push<=tr.push;
   // inter.pop<=tr.pop;
   // @(posedge inter.sysclk);
  endtask
  
  task reset;
    //inter.rst_n<=tr.rst_n;
    inter.data_in=0;
    inter.push=0;
    inter.pop=0;
  endtask 
endclass
