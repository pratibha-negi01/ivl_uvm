//-------------------------------------------------------------------------
//						sva_seq_item 
//-------------------------------------------------------------------------

class sva_seq_item extends uvm_sequence_item;
  //---------------------------------------
  //data and control fields
  //---------------------------------------
   bit  start = 1;
  rand bit  a;
  rand bit  b;
   
  constraint a_rand{ a==1;
                     b==1;
                     }
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(sva_seq_item)
  `uvm_field_int(start,UVM_ALL_ON)
  `uvm_field_int(a,UVM_ALL_ON)
  `uvm_field_int(b,UVM_ALL_ON)
   `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name = "sva_seq_item");
    super.new(name);
  endfunction
  
     
endclass
