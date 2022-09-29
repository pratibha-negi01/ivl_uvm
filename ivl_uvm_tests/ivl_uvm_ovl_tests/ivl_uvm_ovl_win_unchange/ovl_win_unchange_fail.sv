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
	     End1 =0;
	     
	     $display("Running ovl_win_unchange fail Test \n");
	

	     wait_clks(3);
	     
	     $display("ovl_win_unchange does not fire at rst_n \n");
       
	     $monitor("Time=%0d Current value \t rst_n:%0d start_event: %b test_expr :%b  end_event: %b  \n", $time,rst_n,start, test_expr,end1);
	     test_expr =4'b0001;
	     event_start();
	  
	     wait_clks(2);
	     test_expr =4'b0010;
	     
	     wait_clks(2);
	     test_expr =4'b1000;
	

	     wait_clks(2);
	     event_end();
	     test_expr =0;
	

	     $display("Setting rest_n to 1 and giving fail condition \n");
       
	     $display("ovl_win_unchange fires if the test_expression changes it's value  in between start_event and end_event \n" );
	     rst_n = 1;
	     
	     test_expr =4'b0101;
	     event_start();
	     
	     wait_clks(2);
	     test_expr =4'b0100;
	   
	     wait_clks(2);
	     event_end();
	     test_expr =0;
	      
	     wait_clks(2);
	     $display("ovl_win_unchange  fires when test_expression  contains X or Z");
	     test_expr =4'b1000;
	     event_start();
	     wait_clks(2);
	     
	     test_expr =4'b1Z00;
	     
       wait_clks(2);
	     
	     test_expr =4'b11X0;
	     
	     event_end();
	     test_expr =0;
	    
	     wait_clks(2);
	      
	

	      $display("ovl_win_unchange  fires when start_event  contains X or Z");
	      test_expr =4'b0001;
       event_start(1'bX);
	    
	      wait_clks(1);
	

       event_start(1'bZ);
	      
	      test_expr =0;
	      wait_clks(2);
	      
	      $display("ovl_win_unchange  fires when end_event  contains X or Z");
	       test_expr =4'b1001;
	      event_start();
       wait_clks(3);
	      event_end(1'bZ);
	      
       wait_clks(3);
	      event_start();
       wait_clks(3);
       event_end(1'bX);      
	

	       wait_clks(2);
	     $display("ovl_win_unchange fail Test ended \n");
	

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

