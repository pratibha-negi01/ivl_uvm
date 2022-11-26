`define number 190
//`define number_1 5
int error;
//import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo_if.sv"
`include "fifo_trans.sv"
`include "fifo_sequence.sv"
`include "fifo_sequencer.sv"
`include "fifo_dri.sv"
`include "fifo_monitor_act.sv"
`include "fifo_monitor_pas.sv"
`include "fifo_agent_act.sv"
`include "fifo_agent_pas.sv"
`include "fifo_scoreboard.sv"
`include "fifo_env.sv"
`include "fifo_test.sv"

module uvm_top;
  bit clk;
  always #5 clk=~clk;
  fifo_if i(clk);
  //flow fsm(.in(i.in),.reset(i.reset),.out(i.out),.sysclk(sysclk));
  fifo fifi(.data_in(i.data_in),.clk(clk),.rst_n(i.rst_n),.push(i.push),.pop(i.pop),.push_err_on_full(i.push_err_on_full),.pop_err_on_empty(i.pop_err_on_empty),.full(i.full),.empty(i.empty),.data_out(i.data_out));
  
  
  initial
    begin
      uvm_config_db#(virtual fifo_if)::set(null,"","iface",i);
    end
  initial
    begin
      run_test("fifo_tb");
    end
  
    
initial begin //to create vcd file for waveform viewing
  $dumpfile("fifo.vcd");
  $dumpvars;
end
endmodule
