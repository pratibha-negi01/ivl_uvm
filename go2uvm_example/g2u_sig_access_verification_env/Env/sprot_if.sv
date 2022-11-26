////////////////////////////////////////////////////////////////
// Project Name : Go2UVM_sig_access
// Class Name   : sport_if.sv
// Company Name : Verifworks PVT LTD Banglore
// Team Member  : Vaibhav , Ravikumar , Navneet , Radhakrishna
///////////////////////////////////////////////////////////////
interface sprot_if (input bit clk);
  logic   a;
  logic   b;
  logic   rst_n;
  logic   start;
  logic   prot_err;
  logic   xfer_end;
  // End of interface signals 


  // Start of clocking block definition 
  clocking cb @(posedge clk);
    output a;
    output b;
    output rst_n;
    output start;
    input prot_err;
    input xfer_end;
  endclocking : cb
  // End of clocking block definition 
 property a1;
    start |=> a ##1 b;
  endproperty : a1
endinterface : sprot_if
