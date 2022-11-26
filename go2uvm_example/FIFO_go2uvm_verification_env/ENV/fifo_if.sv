`define DATA_WIDTH 8
`define ADDR_WIDTH 4
interface fifo_if(input clk);
  logic [`DATA_WIDTH-1:0] data_in;
  logic rst_n,push,pop;
  logic [`DATA_WIDTH-1:0] data_out;
  logic push_err_on_full,pop_err_on_empty, full,empty;
endinterface
  
