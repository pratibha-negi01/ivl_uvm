//including interfcae and testcase files
`include "sva_interface.sv"
`include "sva_test.sv"
//---------------------------------------------------------------

module tbench_top;

  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  
  bit clk;
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;
  //---------------------------------------
  //interface instance
  //---------------------------------------
  sva_if intf(clk);
  //---------------------------------------
  
     
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual sva_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test();
  end
  
endmodule
