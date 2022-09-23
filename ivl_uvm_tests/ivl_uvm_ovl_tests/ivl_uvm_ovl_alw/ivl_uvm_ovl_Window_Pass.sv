`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;	
   reg test_expr, start_event, end_event;
   

   // simple signal check OVL 
   ovl_window  u_ovl_window ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
	                     .test_expr (test_expr),
	   		     .start_event (start_event),
	  		     .end_event (end_event)
			     );


   initial begin
      // Dump waves
      $dumpfile("pass_dump.vcd");
      $dumpvars(1, test);
      
      // Initialize values.
      rst_n = 0;
      test_expr=0;
      start_event=0;
      end_event=0;
      
     wait_clks(1);
     
     $display("ovl_no_underflow does not fire at rst_n \n");
    
     test_expr=1;
     start_event =1;
	   wait_clks(1);
	   start_event =0;
	   
     
	   wait_clks(13);
     end_event =1;
	    wait_clks(1);
	   end_event =0;
	   
	   
	   wait_clks(2);	   
     test_expr=0;
     wait_clks(1);
     test_expr=1;
     start_event =1;
     
     wait_clks(3);
     end_event =1;
	   
     wait_clks(2);
     
     test_expr=0;
     
     wait_clks(2);
	   $display("ovl_window does not fire if the test_expression is true");
     
     rst_n = 1;
     test_expr=1;
     start_event =1;
     wait_clks(5);
     end_event=1; 
   
	   $display("ovl_window pass after 2 wait_clk \n");
     
      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
