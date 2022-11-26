class sva_scoreboard extends uvm_scoreboard;

  //---------------------------------------
  // Virtual Interface
  //---------------------------------------
  virtual sva_if vif;
  
  //---------------------------------------
  // declaring pkt_qu to store the pkt's recived from monitor
  //---------------------------------------
  sva_seq_item pkt_qu[$];
  
  //---------------------------------------
  // sc_mem 
  //---------------------------------------
  bit [7:0] sc_mem [4];

  //---------------------------------------
  //port to recive packets from monitor
  //---------------------------------------
  uvm_analysis_imp#(sva_seq_item, sva_scoreboard) item_collected_export;
  `uvm_component_utils(sva_scoreboard)

  //---------------------------------------
  // new - constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  //---------------------------------------
  // build_phase - create port and initialize local memory
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      item_collected_export = new("item_collected_export", this);
      foreach(sc_mem[i]) sc_mem[i] = 8'hFF;
  endfunction: build_phase
  
  //---------------------------------------
  // write task - recives the pkt from monitor and pushes into queue
  //---------------------------------------
  virtual function void write(sva_seq_item pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write

  //---------------------------------------
  // local memory will be updated on the write operation.
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    sva_seq_item sva_pkt;
    
    forever begin
      wait(pkt_qu.size() > 0);
      sva_pkt = pkt_qu.pop_front();
      end
       endtask : run_phase
endclass : sva_scoreboard
