`timescale 1ns/1ns
		
		module test;
		
		   wire clk;
		   reg rst_n;
		logic test_exp;
		logic request;
		

//			 logic antecedent_expr, consequent_expr;
			 //logic [7:0] arb_gnt_vec;
		

		   
		   ovl_implication u_olv_implication ( 
					     .clock     (clk),
					     .reset     (rst_n), 
					     .enable    (1'b1),
					     .antecedent_expr (request),
                         . consequent_expr (test_exp)
						 
					     );
		

		

		   // use function
		   ovl_implication u_ovl_req ( 
					     .clock     (clk),
					     .reset     (rst_n), 
					     .enable    (1'b1)
					     //.request (sig)
					     );
		

		   initial begin
		      // Dump waves
		      $dumpfile("dump.vcd");
		      $dumpvars(1, test);
		

		      // Initialize values.
		      rst_n = 0;
		      test_exp = 0;
			  request = 0;
				
				
				
		      $display("ovl_implication does not fire at rst_n");
		      // rst_n=0;
		      //wait_clks(5);
		

		      rst_n = 0;
		      wait_clks(2);
		     // $display("Out of reset");
           
		      //antecedent_expr =0;
              //consequent_expr= 0;
		test_exp=1;	
		request=1;
//state == 1'b1;
		
		   
		
                test_exp=0;
				
		      wait_clks(2);
			   test_exp =1;
			   wait_clks(2);
		      request= 1;
             // $display("checking output when wait_clk is 1");
                
				
				test_exp=0;
				wait_clks(2);
			   test_exp =1;
			   wait_clks(2);
		      request= 1;
 
                
				test_exp=0;
				wait_clks(2);
			   test_exp =0;
			   wait_clks(2);
		      request= 1;
              $display({"ovl_implication has not fire ", "when antecedent_expr is nt true "});
               
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
