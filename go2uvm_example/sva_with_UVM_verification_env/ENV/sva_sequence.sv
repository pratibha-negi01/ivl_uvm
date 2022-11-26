//=========================================================================
// mem_sequence - random stimulus 
//=========================================================================
class sva_sequence extends uvm_sequence#(sva_seq_item);
  
  `uvm_object_utils(sva_sequence)
  
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "sva_sequence");
    super.new(name);
  endfunction
  
  //---------------------------------------
  // create, randomize and send the item to driver
  //---------------------------------------
  virtual task body();
    repeat(10) begin
    req = sva_seq_item::type_id::create("req");
    start_item(req);
      req.randomize() with {req.a==req.b;};
     // `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h wr_en: %0h",req.address_write,req.address_read,req.write_enable),UVM_LOW)
    finish_item(req);
    end  
         
    endtask
endclass
