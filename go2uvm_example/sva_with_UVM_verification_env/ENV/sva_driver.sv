//-------------------------------------------------------------------------
//						sva_driver 
//-------------------------------------------------------------------------

`define DRIV_IF vif.cb

class sva_driver extends uvm_driver #(sva_seq_item);

  //--------------------------------------- 
  // Virtual Interface
  //--------------------------------------- 
  virtual sva_if vif;
  `uvm_component_utils(sva_driver)
    
  //--------------------------------------- 
  // Constructor
  //--------------------------------------- 
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //--------------------------------------- 
  // build phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual sva_if)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase

  //---------------------------------------  
  // run phase
  //---------------------------------------  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  //---------------------------------------
  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals
  //---------------------------------------
  virtual task drive();
    @(posedge vif.clk);
    if(req.start==1)
     begin 
       @(posedge vif.clk);
       @(posedge vif.clk);
     `DRIV_IF.start <= req.start;
     `DRIV_IF.a <=req.a;
       @(posedge vif.clk);  
     `DRIV_IF.b <= req.b;
     end  
    //@(posedge vif.DRIVER.clk_read);
      //`DRIV_IF.address_read <= req.address_read;
    
    //if(req.write_enable) begin // write operation
     // @(posedge vif.DRIVER.clk_write);
     // `DRIV_IF.data_write <= req.data_write;
    //end 
      //@(posedge vif.DRIVER.clk_read);
      // req.data_read = `DRIV_IF.data_read;
     
        
  endtask : drive
endclass : sva_driver
