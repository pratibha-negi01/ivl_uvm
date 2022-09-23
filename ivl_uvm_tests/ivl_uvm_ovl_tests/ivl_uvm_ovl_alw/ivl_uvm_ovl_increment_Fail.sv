`timescale 1ns/1ns

module test;

   reg clk;
   reg rst_n;
  // reg alw_high_sig;
   reg [1:0] count;
   
	// logic wr_val, wr_done;
	 //logic [1:0] arb_gnt_vec;

   // Check wr_val is not same as wr_done
   ovl_increment increment ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (count)
				 
			     );

   // simple signal check OVL 
   ovl_always u_ovl_always ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (alw_high_sig)
			     );

   

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);
	  
	  end

	  
	  initial
		begin
		  rst_n=1;
		  #10;
		  rst_n=0;
	  end
	  
	  
	  
	  initial 
		begin

		repeat (1) @ (posedge clk);
		rst_n=1;

		repeat (1) @ (posedge clk);
		rst_n=0;

		repeat (50) @ (posedge clk);
      
	 
	  count = 2'b01;
		wait_clks(1);
	  count = 1;			

	#50$finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
  
