////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : G2U_sig_access_transection
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////
typedef enum bit [1:0] {IDLE, A_ST, B_ST} sprot_fsm_t;
class G2U_sig_access_trans extends uvm_sequence_item;

   randc bit a;
   rand bit b = 1;
   logic [7:0] byte_val, byte_val_1;
   rand logic start_state;
   rand logic next_state;
   rand bit [3:0]cmd;
   sprot_fsm_t  kind;
   parameter  IDLE=1'b0,
            A_ST=1'b1,
            B_ST=1'b1;
   `uvm_object_utils_begin(G2U_sig_access_trans)
   `uvm_field_int(start_state, UVM_ALL_ON)
   `uvm_field_int(next_state, UVM_ALL_ON)
	 `uvm_field_int(a, UVM_ALL_ON)
	 `uvm_field_int(b, UVM_ALL_ON)
	 `uvm_field_int(cmd,UVM_ALL_ON)
	 `uvm_field_enum(sprot_fsm_t, kind, UVM_ALL_ON)
	`uvm_object_utils_end
	
	
 `ifdef aldec
  constraint c1 {kind inside {IDLE, A_ST, B_ST},}
  `else
  constraint c1
  {kind dist {IDLE := 2, A_ST := 4, B_ST := 4};}
  `endif
	function new (string name = "G2U_sig_access_trans");
	  super.new(name);
	endfunction

endclass
