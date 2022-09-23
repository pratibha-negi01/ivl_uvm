`timescale 1ns/1ns
		
		module test;
		
		   wire clk;
		   reg rst_n;
		logic test_exp;
		logic request;
		
		   ovl_implication u_olv_implication ( 
					     .clock     (clk),
					     .reset     (rst_n), 
					     .enable    (1'b1),
					     .antecedent_expr (request),
                                             . consequent_expr (test_exp)
						 
					     );
	
		   initial begin
		      // Dump waves
		      $dumpfile("dump.vcd");
		      $dumpvars(1, test);
		

		      // Initialize values.
		      rst_n = 0;
		      test_exp = 0;
		      request = 0;
			
		      rst_n = 0;
		      wait_clks(2);
		      $display("Out of reset");
           
		      //antecedent_expr =1;
              //consequent_expr= 1;
		test_exp=1;	
		request=1;
	     $display({"ovl_implication has fire ",
		               "when antecedent_expr and consequent_expr are true "});
		
                test_exp=0;
				
		      wait_clks(2);
		      test_exp =1;
		      wait_clks(2);
		      request= 1;
                
				
	              test_exp=0;
		      wait_clks(2);
		      test_exp =1;
		      wait_clks(2);
		      request= 1;
      
                
			test_exp=0;
			wait_clks(2);
			test_exp =1;
			wait_clks(2);
		        request= 1;
              $display("checking output when wait_clk is 2");
               
			test_exp = 0;
			wait_clks(2);
			request=1;
			
$finish;
		   end
		

		   task wait_clks (input int num_clks = 2);
		      repeat (num_clks) @(posedge clk);
		   endtask : wait_clks
		

		  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);
		

		endmodule









