`timescale 1ns/1ns
	

	module test;
	

	   wire clk;
	   reg rst_n;
	   reg [3:0] test_expr;
	   reg start,end1;
	

	   // simple signal check OVL 
	   ovl_win_unchange #(.width(4))  u_ovl_win_unchange ( 
				     .clock     (clk),
				     .reset     (rst_n), 
				     .enable    (1'b1),
				     .test_expr (test_expr),
	                             .start_event (start),
	                             .end_event (end1)
				     );
	

	

	   initial begin
	      // Dump waves
	      $dumpfile("fail_dump.vcd");
	      $dumpvars(1, test);
	      
	      // Initialize values.
	      rst_n = 0;
	      start=0;
	     test_expr =0;
	     end1=0;
	     
	     $display("Running ovl_win_unchange Pass Test \n");
	

	     wait_clks(2);
	  
	     $display("Setting rest_n to 0 and giving  fail conditions \n");
	     
	     $display("ovl_win_unchange does not fire at rst_n \n");
	     $monitor("Time=%0d Current value \t rst_n:%0d start_event: %b test_expr :%b  end_event: %b  \n", $time,rst_n,start,a,done);
	     test_expr =4'b0001;
	     event_start();
	  
       wait_clks(3);
	     test_expr =4'b1000;
	  
       wait_clks(3);
	     event_end();
	     test_expr =0;
	

	     $display("Setting rest_n to 1 and giving pass condition \n");
	     $display("ovl_win_unchange doesn't fire if the test_expression is not changed the value in between start_event and end_event \n" );
	     rst_n = 1;
	     
	     test_expr =4'b0011;
	     event_start();
	     
	     wait_clks(4);
	

	     event_end();
	     test_expr =0;
	      
	

	    wait_clks(2);
	      test_expr =4'b1001;
	     event_start();
	     wait_clks(3);
	     
	     
	   
	     event_end();
	     test_expr =0;
	   
	      
	

	       wait_clks(2);
	     $display("ovl_win_unchange pass Test ended \n");
	

	      $finish;
	   end
	

	   task event_start( input logic value=1);
	     start= value;
	     wait_clks(1);
	     start= 0;   
	   endtask : event_start
	

	  
	   task event_end( input logic value=1);
	     end1= value;
	     wait_clks(1);
	     end1=0;
	   endtask : event_end
	

	

	   task wait_clks (input int num_clks = 1);
	      repeat (num_clks) @(posedge clk);
	   endtask : wait_clks
	

	  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);
	

	endmodule
