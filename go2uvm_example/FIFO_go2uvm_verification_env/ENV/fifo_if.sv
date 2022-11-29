import fifo_pkg::*;

interface fifo_if(input logic clk);
  logic rst,push,pop,full,empty;
  logic [`DATA_WIDTH-1:0] data_in;
  logic [`DATA_WIDTH-1:0] data_out;
  logic push_err_on_full,pop_err_on_empty;
  
  clocking driver_cb@(posedge clk);
    
    output rst,push,pop;
    output data_in;
    input data_out;
    input full,empty;
    input push_err_on_full,pop_err_on_empty;
    
  endclocking : driver_cb
  
  clocking monitor_cb@(posedge clk);
    input rst,push,pop;
    input data_in;
    input data_out;
    input full,empty;
    input push_err_on_full,pop_err_on_empty;
    
  endclocking : monitor_cb
 
  
endinterface : fifo_if
