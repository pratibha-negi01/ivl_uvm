//-------------------------------------------------------------------------
//						mem_interface 
//-------------------------------------------------------------------------
interface sva_if (input clk);
  logic rst_n;
  logic start, a, b;

  default clocking cb @ (posedge clk);
    output start, a, b;
  endclocking : cb

  a1 : assert property (start |=> a ##1 b) else
    `uvm_info ("SVA-UVM",$sformatf("A: %0h B: %0h start: %0h  Protocol violation, no a ##1 b",a,b,start),UVM_LOW);
  //---------------------------------------
  //driver clocking block
  //---------------------------------------
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output start;
    output a;
    output b;
  endclocking
  
  //---------------------------------------
  //monitor clocking block
  //---------------------------------------
 clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input start;
    input a;
    input b;  
  endclocking
  
  //---------------------------------------
  //driver modport
  //---------------------------------------
  modport DRIVER  (clocking driver_cb,input clk);
  
  //---------------------------------------
  //monitor modport  
  //---------------------------------------
  modport MONITOR (clocking monitor_cb,input clk);
 
endinterface
